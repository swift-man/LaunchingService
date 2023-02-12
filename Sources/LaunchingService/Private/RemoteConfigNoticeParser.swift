//
//  RemoteConfigNoticeParser.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import FirebaseRemoteConfig

final class RemoteConfigNoticeParser: Sendable {
  let keyStore: RemoteConfigRegisterdKeys
  
  init(keyStore: RemoteConfigRegisterdKeys) {
    self.keyStore = keyStore
  }
  
  func parseNotice() -> NoticeInfo? {
    guard
      let noticeStartDate,
        let noticeEndDate,
        noticeStartDate < noticeEndDate
    else { return nil }
    
    let range = noticeStartDate...noticeEndDate
    guard range.contains(Date()) else { return nil }
    
    return NoticeInfo(title: noticeAlertTitle,
                      message: noticeAlertMessage,
                      isAppTerminated: noticeAlertDismissedTerminate,
                      dateRange: noticeStartDate ... noticeEndDate,
                      doneURL: noticeAlertDoneURL)
  }
  
  var noticeAlertTitle: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeKeys.alertTitleKey)
      .stringValue ?? ""
  }
  
  var noticeAlertMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeKeys.alertMessageKey)
      .stringValue ?? ""
  }
  
  var noticeStartDate: Date? {
    guard
      let startDateString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.noticeKeys.startDateKey)
        .stringValue
    else { return nil }
    
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    return dateFormatter.date(from: startDateString)
  }
  
  var noticeEndDate: Date? {
    guard
      let endDateString = RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeKeys.endDateKey)
      .stringValue
    else { return nil }
    
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime]
    return dateFormatter.date(from: endDateString)
  }
  
  var noticeAlertDismissedTerminate: Bool {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeKeys.alertDismissedTerminateKey)
      .boolValue
  }
  
  var noticeAlertDoneURL: URL? {
    let urlString = RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeKeys.alertDoneURLKey)
      .stringValue ?? ""
    
    return URL(string: urlString)
  }
}
