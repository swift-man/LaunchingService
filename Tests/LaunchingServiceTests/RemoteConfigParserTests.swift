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
