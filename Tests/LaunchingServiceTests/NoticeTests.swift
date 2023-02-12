//
//  NoticeTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

@MainActor
final class NoticeTests: LaunchingServiceTests {
  func testNotice_1() async throws {
    let title = "title"
    let message = "message"
    let isAppTerminated = true
    let doneURL = URL(string: "https://github.com/swift-man/LaunchingService")!
    
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "",
                blackListVersions: [],
                notice: NoticeInfo(title: title,
                                   message: message,
                                   isAppTerminated: isAppTerminated,
                                   dateRange: Date().addingTimeInterval(-5000) ... Date().addingTimeInterval(5000),
                                   doneURL: doneURL),
                isEqualStatus: .notice(NoticeAlert(title: title,
                                                   message: message,
                                                   isAppTerminated: isAppTerminated,
                                                   doneURL: doneURL)))
  }
  
  func testNotice_2() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "",
                blackListVersions: [],
                notice: NoticeInfo(title: "title",
                                   message: "message",
                                   isAppTerminated: true,
                                   dateRange: Date().addingTimeInterval(5000) ... Date().addingTimeInterval(15000),
                                   doneURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                isEqualStatus: .valid)
  }
  
  func testNotice_3() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "",
                blackListVersions: [],
                notice: NoticeInfo(title: "title",
                                   message: "message",
                                   isAppTerminated: true,
                                   dateRange: Date().addingTimeInterval(-15000) ... Date().addingTimeInterval(-10000),
                                   doneURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                isEqualStatus: .valid)
  }
}
