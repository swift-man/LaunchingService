//
//  OptionalUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

final class OptionalUpdateTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testDataOptionalVersionRequired_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                      message: message),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertTrue(appStatus == .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testDataOptionalVersionRequired_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "optionalUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "2.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "2.0.1",
                                                                                      message: message),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .optionalUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testDataOptionalVersionRequired_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "optionalUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "10.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.1",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "10.0.1",
                                                                                      message: message),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .optionalUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testDataOptionalVersionValid_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "optionalUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.0",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "0.9.0",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testDataOptionalVersionValid_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "0.9.2",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testDataOptionalVersionValid_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.1",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "0.5.1",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
}
