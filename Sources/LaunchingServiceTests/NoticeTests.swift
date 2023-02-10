//
//  NoticeTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

final class NoticeTests: XCTestCase {
  var service: LaunchingInteractable?
  
  func testNotice_1() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    
    let title = "title"
    let message = "message"
    let isAppTerminated = true
    let doneURL = url
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: NoticeInfo(title: title,
                                                                           message: "message",
                                                                           isAppTerminated: isAppTerminated,
                                                                           dateRange: Date().addingTimeInterval(-5000) ... Date().addingTimeInterval(5000),
                                                                           doneURL: doneURL)
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .notice(NoticeAlert(title: title,
                                                    message: message,
                                                    isAppTerminated: isAppTerminated,
                                                    doneURL: doneURL)))
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testNotice_2() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    
    let title = "title"
    let message = "message"
    let isAppTerminated = true
    let doneURL = url
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: NoticeInfo(title: title,
                                                                           message: "message",
                                                                           isAppTerminated: isAppTerminated,
                                                                           dateRange: Date().addingTimeInterval(5000) ... Date().addingTimeInterval(15000),
                                                                           doneURL: doneURL)
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
  
  func testNotice_3() async throws {
    let url = URL(string: "https://github.com/swift-man/LaunchingService")!
    
    let title = "title"
    let message = "message"
    let isAppTerminated = true
    let doneURL = url
    service = LaunchingServiceMock(releaseVersion: "1.0.0",
                                   launching: Launching(forceUpdate: AppUpdateInfo(version: "",
                                                                                   message: "forceUpdate"),
                                                        optionalUpdate: AppUpdateInfo(version: "",
                                                                                      message: "optionalUpdate"),
                                                        blackListVersions: [],
                                                        appStoreURL: url,
                                                        notice: NoticeInfo(title: title,
                                                                           message: "message",
                                                                           isAppTerminated: isAppTerminated,
                                                                           dateRange: Date().addingTimeInterval(-15000) ... Date().addingTimeInterval(-10000),
                                                                           doneURL: doneURL)
                                   ))
    do {
      let appStatus = try await service?.fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore())
      XCTAssertEqual(appStatus, .valid)
    } catch {
      XCTFail("Wrong error")
    }
  }
}
