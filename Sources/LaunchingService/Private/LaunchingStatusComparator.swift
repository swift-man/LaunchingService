//
//  LaunchingStatusComparator.swift
//
//
//  Created by SwiftMan on 2026/07/08.
//

import Foundation

struct LaunchingStatusComparator: Sendable {
  func compare(releaseVersion: String, launching: Launching) -> AppUpdateStatus {
    var appStatus = AppUpdateStatusChecker().compare(releaseVersion: releaseVersion,
                                                     launching: launching)

    if appStatus == .valid {
      appStatus = NoticeChecker().compare(launching: launching)
    }

    return appStatus
  }
}
