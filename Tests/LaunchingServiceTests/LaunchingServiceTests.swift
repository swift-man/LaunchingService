//
//  LaunchingServiceTests.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation
import Testing
import LaunchingService

@Suite("LaunchingService")
@MainActor
struct LaunchingServiceTests {
  @Test func remoteConfigDataAllVersionIsEmpty() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func remoteConfigDataForceVersionIsEmpty() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  @Test func remoteConfigDataOptionalVersionIsEmpty() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "",
                                    optionalUpdate: "1.0.1",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .optionalUpdateRequired(.mock))
  }
}

@MainActor
func expectAppUpdateStatus(releaseVersion: String,
                           forceVersion: String,
                           optionalUpdate: String,
                           blackListVersions: [String],
                           notice: NoticeInfo?,
                           isEqualStatus: AppUpdateStatus) async throws {
  let service = LaunchingServiceMock(releaseVersion: releaseVersion,
                                     launching: Launching(forceUpdate: AppUpdateInfo(version: forceVersion,
                                                                                     alertTitle: "",
                                                                                     alertMessage: "",
                                                                                     alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                                          optionalUpdate: AppUpdateInfo(version: optionalUpdate,
                                                                                        alertTitle: "",
                                                                                        alertMessage: "",
                                                                                        alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                                          blackListVersions: blackListVersions,
                                                          notice: notice))

  let appStatus = try await service.fetchAppUpdateStatus()
  #expect(appStatus == isEqualStatus)
}
