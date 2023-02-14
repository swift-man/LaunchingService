//
//  Launching.swift
//  
//
//  Created by SwiftMan on 2023/02/08.
//

import Foundation

@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public struct Launching: Sendable {
  public let forceUpdate: AppUpdateInfo
  public let optionalUpdate: AppUpdateInfo
  public let blackListVersions: [String]
  
  public let notice: NoticeInfo?
  
  public init(forceUpdate: AppUpdateInfo,
              optionalUpdate: AppUpdateInfo,
              blackListVersions: [String],
              notice: NoticeInfo?) {
    self.forceUpdate = forceUpdate
    self.optionalUpdate = optionalUpdate
    self.blackListVersions = blackListVersions
    self.notice = notice
  }
}

@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public struct AppUpdateInfo: Sendable {
  public let version: String
  public let alertTitle: String
  public let alertMessage: String
  public let alertDoneLinkURL: URL
  
  public init(version: String,
              alertTitle: String,
              alertMessage: String,
              alertDoneLinkURL: URL) {
    self.version = version
    self.alertTitle = alertTitle
    self.alertMessage = alertMessage
    self.alertDoneLinkURL = alertDoneLinkURL
  }
}

/// 공지 얼럿 정보
@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public struct NoticeInfo: Sendable, Equatable {
  /// alert title: 얼럿 타이틀
  public let title: String
  
  /// alert message: 얼럿 메시지
  public let message: String
  
  /// alert isAppTerminated: 얼럿 확인 후 앱 종료 여부
  public let isAppTerminated: Bool
  
  /// alert doneURL: 확인 후 랜딩 URL
  public let doneURL: URL?
  
  public let dateRange: ClosedRange<Date>
  
  public init(title: String,
              message: String,
              isAppTerminated: Bool,
              dateRange: ClosedRange<Date>,
              doneURL: URL?) {
    self.title = title
    self.message = message
    self.isAppTerminated = isAppTerminated
    self.dateRange = dateRange
    self.doneURL = doneURL
  }
}
