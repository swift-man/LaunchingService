//
//  NoticeTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation
import Testing
@testable import LaunchingService

@Suite("Notice")
@MainActor
struct NoticeTests {
  private static let referenceDate = Date(timeIntervalSince1970: 1_704_067_200)

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
                                                       dateRange: Self.referenceDate.addingTimeInterval(-5000) ... Self.referenceDate.addingTimeInterval(5000),
                                                       doneURL: doneURL),
                                    dateProvider: DateProviderMock(now: Self.referenceDate),
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
                                                       dateRange: Self.referenceDate.addingTimeInterval(5000) ... Self.referenceDate.addingTimeInterval(15000),
                                                       doneURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                    dateProvider: DateProviderMock(now: Self.referenceDate),
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
                                                       dateRange: Self.referenceDate.addingTimeInterval(-15000) ... Self.referenceDate.addingTimeInterval(-10000),
                                                       doneURL: URL(string: "https://github.com/swift-man/LaunchingService")!),
                                    dateProvider: DateProviderMock(now: Self.referenceDate),
                                    isEqualStatus: .valid)
  }
}
