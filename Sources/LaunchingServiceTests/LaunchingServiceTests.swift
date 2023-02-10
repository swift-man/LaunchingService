//
//  LaunchingServiceTests.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import XCTest
import LaunchingService

final class LaunchingServiceTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testRemoteConfigDataAllVersionIsEmpty_1() async throws {
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: URL(string: "https://github.com/swift-man/LaunchingService")!,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testRemoteConfigDataForceVersionIsEmpty_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testRemoteConfigDataOptionalVersionIsEmpty_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "optionalUpdate"
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                      message: message),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .optionalUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
}
