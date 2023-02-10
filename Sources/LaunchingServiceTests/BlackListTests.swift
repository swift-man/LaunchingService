//
//  BlackListTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

final class BlackListTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testBlackListRequired_0() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    service = LaunchingServiceMock(releaseVersion: "2.3.10",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "0.0.5",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["2.3.9", "2.3.10", "2.3.11"],
                                                        appStoreURL: URL(string: "https://github.com/swift-man/LaunchingService")!,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testBlackListRequired_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    service = LaunchingServiceMock(releaseVersion: "12.3",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "11.0.9",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "15.0.5",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["12.3.0", "12.3", "12"],
                                                        appStoreURL: URL(string: "https://github.com/swift-man/LaunchingService")!,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testBlackListRequired_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    service = LaunchingServiceMock(releaseVersion: "1.0.10",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "0.0.5",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["2.3.9", "2.3.10", "1.0.10"],
                                                        appStoreURL: URL(string: "https://github.com/swift-man/LaunchingService")!,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testBlackListRequired_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    service = LaunchingServiceMock(releaseVersion: "0.3.10",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "0.0.5",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["0.3.10"],
                                                        appStoreURL: URL(string: "https://github.com/swift-man/LaunchingService")!,
                                                        notice: nil
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .forcedUpdateRequired(UpdateAlert(message: message, appstoreURL: url)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testBlackListVersionValid_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "2.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "2.0.0",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["1.9.1"],
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
  
  func testBlackListVersionValid_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    let message = "forceUpdate"
    
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "0.0.9",
                                                                                   message: message),
                                                        optionalUpdate: AppUpdateInfo(version: "0",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: ["1.0.1"],
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
  
  func testBlackListVersionValid_3() async throws {
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
