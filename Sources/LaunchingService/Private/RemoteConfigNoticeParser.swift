//
//  RemoteConfigNoticeParser.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation

final class RemoteConfigNoticeParser: Sendable {
  private let keyStore: RemoteConfigRegisterdKeys
  private let valueProvider: any RemoteConfigValueProviding
  
  init(keyStore: RemoteConfigRegisterdKeys,
       valueProvider: any RemoteConfigValueProviding = FirebaseRemoteConfigClient()) {
    self.keyStore = keyStore
    self.valueProvider = valueProvider
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
  
  private var noticeAlertTitle: String {
    valueProvider.stringValue(forKey: keyStore.noticeKeys.alertTitleKey)
  }
  
  private var noticeAlertMessage: String {
    valueProvider.stringValue(forKey: keyStore.noticeKeys.alertMessageKey)
  }
  
  private var noticeStartDate: Date? {
    guard let startDateString = valueProvider
      .stringValue(forKey: keyStore.noticeKeys.startDateKey)
      .nilIfBlank
    else { return nil }
    
    return Self.date(from: startDateString)
  }
  
  private var noticeEndDate: Date? {
    guard let endDateString = valueProvider
      .stringValue(forKey: keyStore.noticeKeys.endDateKey)
      .nilIfBlank
    else { return nil }
    
    return Self.date(from: endDateString)
  }
  
  private var noticeAlertDismissedTerminate: Bool {
    valueProvider.boolValue(forKey: keyStore.noticeKeys.alertDismissedTerminateKey)
  }
  
  private var noticeAlertDoneURL: URL? {
    guard let urlString = valueProvider
      .stringValue(forKey: keyStore.noticeKeys.alertDoneURLKey)
      .nilIfBlank
    else { return nil }
    
    return URL(string: urlString)
  }

  private static func date(from string: String) -> Date? {
    try? Date.ISO8601FormatStyle().parse(string)
  }
}
