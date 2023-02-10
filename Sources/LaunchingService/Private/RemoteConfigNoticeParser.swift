//
//  RemoteConfigNoticeParser.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import FirebaseRemoteConfig

final class RemoteConfigNoticeParser: Sendable {
  let keyStore: LaunchingServiceKeyStore
  
  init(keyStore: LaunchingServiceKeyStore) {
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
                      dateRange: noticeStartDate...noticeEndDate,
                      doneURL: noticeAlertDoneURL)
  }
  
  var noticeAlertTitle: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeAlertTitleKey)
      .stringValue ?? ""
  }
  
  var noticeAlertMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeAlertMessageKey)
      .stringValue ?? ""
  }
  
  var noticeStartDate: Date? {
    guard
      let startDateString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.noticeStartDateKey)
        .stringValue
    else { return nil }
    
    return dateFormatter.date(from: startDateString)
  }
  
  var noticeEndDate: Date? {
    guard
      let endDateString = RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeEndDateKey)
      .stringValue
    else { return nil }
    
    return dateFormatter.date(from: endDateString)
  }
  
  var noticeAlertDismissedTerminate: Bool {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeAlertDismissedTerminateKey)
      .boolValue
  }
  
  var noticeAlertDoneURL: URL? {
    let urlString = RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.noticeAlertDoneURLKey)
      .stringValue ?? ""
    
    return URL(string: urlString)
  }
  
  private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    return formatter
  }()
}
