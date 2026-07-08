//
//  NoticeChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation

struct NoticeChecker: Sendable {
  private let dateProvider: any DateProviding

  init(dateProvider: any DateProviding = SystemDateProvider()) {
    self.dateProvider = dateProvider
  }

  func compare(launching: Launching) -> AppUpdateStatus {
    if let notice = launching.notice, notice.dateRange.contains(dateProvider.now) {
      return .notice(NoticeAlert(title: notice.title,
                                 message: notice.message,
                                 isAppTerminated: notice.isAppTerminated,
                                 doneURL: notice.doneURL))
    }
    
    return .valid
  }
}
