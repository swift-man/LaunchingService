//
//  NoticeAlert+NoticeInfo.swift
//
//
//  Created by SwiftMan on 2026/07/08.
//

extension NoticeAlert {
  init(notice: NoticeInfo) {
    self.init(title: notice.title,
              message: notice.message,
              isAppTerminated: notice.isAppTerminated,
              doneURL: notice.doneURL)
  }
}
