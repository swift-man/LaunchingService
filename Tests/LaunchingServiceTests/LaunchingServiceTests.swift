//
//  LaunchingServiceTests.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import XCTest
import LaunchingService

class LaunchingServiceTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testRemoteConfigDataAllVersionIsEmpty_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testRemoteConfigDataForceVersionIsEmpty_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.1",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testRemoteConfigDataOptionalVersionIsEmpty_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "1.0.1",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .optionalUpdateRequired(.mock))
  }
  
  func tests(releaseVersion: String,
             forceVersion: String,
             optionalUpdate: String,
             blackListVersions: [String],
             notice: NoticeInfo?,
             isEqualStatus: AppUpdateStatus) async {
    service = LaunchingServiceMock(releaseVersion: releaseVersion,
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: forceVersion,
                                                                                   alertTitle: "",
                                                                                   alertMessage: "",
                                                                                   alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                                        optionalUpdate: AppUpdateInfo(version: optionalUpdate,
                                                                                      alertTitle: "",
                                                                                      alertMessage: "",
                                                                                      alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                                        blackListVersions: blackListVersions,
                                                        notice: notice
                                   ))
    
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: RemoteConfigRegisterdKeys())
      XCTAssertEqual(appStatus, isEqualStatus)
    } catch {
      XCTFail("Wrong error")
    }
  }
}

