//
//  LaunchingStatusComparator.swift
//
//
//  Created by SwiftMan on 2026/07/08.
//

import Foundation

struct LaunchingStatusComparator: Sendable {
  private let dateProvider: any DateProviding

  init(dateProvider: any DateProviding = SystemDateProvider()) {
    self.dateProvider = dateProvider
  }

  func compare(releaseVersion: String, launching: Launching) -> AppUpdateStatus {
    var appStatus = AppUpdateStatusChecker().compare(releaseVersion: releaseVersion,
                                                     launching: launching)

    if appStatus == .valid {
      appStatus = NoticeChecker(dateProvider: dateProvider).compare(launching: launching)
    }

    return appStatus
  }
}
