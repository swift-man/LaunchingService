//
//  NoticeChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation

final class NoticeChecker: Sendable {
  func compare(launching: Launching) -> AppUpdateStatus {
    if let notice = launching.notice, notice.dateRange.contains(Date()) {
      return .notice(NoticeAlert(title: notice.title,
                                 message: notice.message,
                                 isAppTerminated: notice.isAppTerminated,
                                 doneURL: notice.doneURL))
    }
    
    return .valid
  }
}
