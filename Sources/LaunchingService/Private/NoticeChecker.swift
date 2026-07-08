//
//  NoticeChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Dependencies
import Foundation

struct NoticeChecker: Sendable {
  @Dependency(\.date.now)
  private var now

  func compare(launching: Launching) -> AppUpdateStatus {
    if let notice = launching.notice, notice.dateRange.contains(now) {
      return .notice(NoticeAlert(notice: notice))
    }

    return .valid
  }
}
