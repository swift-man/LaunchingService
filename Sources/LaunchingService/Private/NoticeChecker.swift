//
//  NoticeChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Dependencies
import Foundation

struct NoticeChecker: Sendable {
  func compare(launching: Launching) -> AppUpdateStatus {
    @Dependency(\.date.now)
    var now

    if let notice = launching.notice, notice.dateRange.contains(now) {
      return .notice(NoticeAlert(title: notice.title,
                                 message: notice.message,
                                 isAppTerminated: notice.isAppTerminated,
                                 doneURL: notice.doneURL))
    }
    
    return .valid
  }
}
