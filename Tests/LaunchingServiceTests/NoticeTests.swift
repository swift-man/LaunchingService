//
//  NoticeTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation
import Testing
import LaunchingService

@Suite("Notice")
@MainActor
struct NoticeTests {
  @Test func notice_1() async throws {
    let title = "title"
    let message = "message"
    let isAppTerminated = true
    let doneURL = URL(string: "https://github.com/swift-man/LaunchingService")!
    
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
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
  
  @Test func notice_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
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
  
  @Test func notice_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
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
