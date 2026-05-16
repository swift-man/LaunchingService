//
//  RemoteConfigParserTests.swift
//
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation
import Testing
@testable import LaunchingService

@Suite("RemoteConfigParser")
@MainActor
struct RemoteConfigParserTests {
  @Test func forceUpdateParserKeepsAlertInfoWhenForceVersionIsMissing() {
    let parser = RemoteConfigForceUpdateParser(
      keyStore: RemoteConfigRegisterdKeys(),
      valueProvider: RemoteConfigClientMock(strings: [
        "forceUpdateAlertTitleKey": "Force update",
        "forceUpdateAlertMessageKey": "Please update",
        "forceUpdateAlertDoneLinkURLKey": "https://example.com/force"
      ])
    )

    let appUpdateInfo = parser.parseAppUpdateInfo()

    #expect(appUpdateInfo.version == "")
    #expect(appUpdateInfo.alertTitle == "Force update")
    #expect(appUpdateInfo.alertMessage == "Please update")
    #expect(appUpdateInfo.alertDoneLinkURL == URL(string: "https://example.com/force")!)
  }

  @Test func forceUpdateParserReturnsInactiveInfoWhenDoneURLIsMissing() {
    let parser = RemoteConfigForceUpdateParser(
      keyStore: RemoteConfigRegisterdKeys(),
      valueProvider: RemoteConfigClientMock(strings: [
        "forceUpdateAppVersionKey": "2.0.0",
        "forceUpdateAlertTitleKey": "Force update",
        "forceUpdateAlertMessageKey": "Please update"
      ])
    )

    let appUpdateInfo = parser.parseAppUpdateInfo()

    #expect(appUpdateInfo.version == "")
    #expect(appUpdateInfo.alertDoneLinkURL == URL(string: "about:blank")!)
  }

  @Test func forceUpdateParserDisablesBlackListVersionsWhenDoneURLIsMissing() {
    let parser = RemoteConfigForceUpdateParser(
      keyStore: RemoteConfigRegisterdKeys(),
      valueProvider: RemoteConfigClientMock(strings: [
        "blackListVersionsKey": "1.0.0, 1.1.0"
      ])
    )

    #expect(parser.parseBlackListVersions() == [])
  }

  @Test func remoteConfigParserUsesInjectedValuesWithoutFirebase() {
    let parser = RemoteConfigParser(
      valueProvider: RemoteConfigClientMock(strings: [
        "forceUpdateAppVersionKey": "2.0.0",
        "forceUpdateAlertTitleKey": "Force update",
        "forceUpdateAlertMessageKey": "Please update",
        "forceUpdateAlertDoneLinkURLKey": "https://example.com/force",
        "optionalUpdateAppVersionKey": "1.5.0",
        "optionalUpdateAlertTitleKey": "Optional update",
        "optionalUpdateAlertMessageKey": "A new version is available",
        "optionalUpdateAlertDoneLinkURLKey": "https://example.com/optional",
        "blackListVersionsKey": " 1.0.0, , 1.1.0 "
      ])
    )

    let launching = parser.parse()

    #expect(launching.forceUpdate.version == "2.0.0")
    #expect(launching.forceUpdate.alertTitle == "Force update")
    #expect(launching.forceUpdate.alertDoneLinkURL == URL(string: "https://example.com/force")!)
    #expect(launching.optionalUpdate.version == "1.5.0")
    #expect(launching.blackListVersions == ["1.0.0", "1.1.0"])
    #expect(launching.notice == nil)
  }

  @Test func remoteConfigParserParsesNoticeDatesWithISO8601FormatStyle() {
    let iso8601Style = Date.ISO8601FormatStyle()
    let doneURL = URL(string: "https://example.com/notice")!
    let parser = RemoteConfigParser(
      valueProvider: RemoteConfigClientMock(
        strings: [
          "noticeAlertTitleKey": "Notice",
          "noticeAlertMessageKey": "Scheduled maintenance",
          "noticeStartDateKey": iso8601Style.format(Date().addingTimeInterval(-5000)),
          "noticeEndDateKey": iso8601Style.format(Date().addingTimeInterval(5000)),
          "noticeAlertDoneURLKey": doneURL.absoluteString
        ],
        bools: [
          "noticeAlertDismissedTerminateKey": true
        ]
      )
    )

    let notice = parser.parse().notice

    #expect(notice?.title == "Notice")
    #expect(notice?.message == "Scheduled maintenance")
    #expect(notice?.isAppTerminated == true)
    #expect(notice?.doneURL == doneURL)
    #expect(notice?.dateRange.contains(Date()) == true)
  }

  @Test func remoteConfigParserContinuesToParseNoticeDatesWithCompactTimeZone() {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

    let parser = RemoteConfigParser(
      valueProvider: RemoteConfigClientMock(strings: [
        "noticeAlertTitleKey": "Notice",
        "noticeAlertMessageKey": "Scheduled maintenance",
        "noticeStartDateKey": dateFormatter.string(from: Date().addingTimeInterval(-5000)),
        "noticeEndDateKey": dateFormatter.string(from: Date().addingTimeInterval(5000))
      ])
    )

    let notice = parser.parse().notice

    #expect(notice?.title == "Notice")
    #expect(notice?.dateRange.contains(Date()) == true)
  }

  @Test func fetchAppUpdateStatusContinuesWithCachedConfigWhenFetchFails() async throws {
    let remoteConfigClient = RemoteConfigClientMock(
      strings: [
        "optionalUpdateAppVersionKey": "2.0.0",
        "optionalUpdateAlertTitleKey": "Optional update",
        "optionalUpdateAlertMessageKey": "A new version is available",
        "optionalUpdateAlertDoneLinkURLKey": "https://example.com/optional"
      ],
      fetchError: RemoteConfigClientMockError.fetchFailed
    )
    let service = LaunchingService(
      remoteConfigClient: remoteConfigClient,
      appVersionProvider: AppReleaseVersionProviderMock(version: "1.0.0")
    )

    let status = try await service.fetchAppUpdateStatus()

    #expect(
      status == .optionalUpdateRequired(
        UpdateAlert(title: "Optional update",
                    message: "A new version is available",
                    alertDoneLinkURL: URL(string: "https://example.com/optional")!)
      )
    )
  }

  @Test func fetchAppUpdateStatusDoesNotForceUpdateFromBlackListWhenForceURLIsMissing() async throws {
    let remoteConfigClient = RemoteConfigClientMock(
      strings: [
        "blackListVersionsKey": "1.0.0"
      ]
    )
    let service = LaunchingService(
      remoteConfigClient: remoteConfigClient,
      appVersionProvider: AppReleaseVersionProviderMock(version: "1.0.0")
    )

    let status = try await service.fetchAppUpdateStatus()

    #expect(status == .valid)
  }
}

private enum RemoteConfigClientMockError: Error {
  case fetchFailed
}

private struct RemoteConfigClientMock: RemoteConfigClient {
  let strings: [String: String]
  let bools: [String: Bool]
  let fetchError: RemoteConfigClientMockError?

  init(strings: [String: String] = [:],
       bools: [String: Bool] = [:],
       fetchError: RemoteConfigClientMockError? = nil) {
    self.strings = strings
    self.bools = bools
    self.fetchError = fetchError
  }

  func fetchAndActivate() async throws {
    if let fetchError {
      throw fetchError
    }
  }

  func stringValue(forKey key: String) -> String {
    strings[key] ?? ""
  }

  func boolValue(forKey key: String) -> Bool {
    bools[key] ?? false
  }
}

private struct AppReleaseVersionProviderMock: AppReleaseVersionProviding {
  let version: String

  func releaseVersion() throws -> String {
    version
  }
}
