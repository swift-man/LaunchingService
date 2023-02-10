//
//  ForceUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

final class ForceUpdateTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testAllVersionIsEmpty_1() async throws {
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
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testForceVersionRequired_1() async throws {
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
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testForceVersionRequired_2() async throws {
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
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testForceVersionRequired_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "2.0.5",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testForceVersionValid_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "1.0.0",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
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
  
  func testForceVersionValid_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
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
  
  func testForceVersionValid_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.1",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
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
