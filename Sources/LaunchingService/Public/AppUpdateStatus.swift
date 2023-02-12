//
//  AppUpdateStatus.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

/// Result types App Update Status
public enum AppUpdateStatus: Equatable, Sendable {
  /// 유효
  case valid
  
  /// 강제 업데이트 필요
  /// - Parameters:
  ///   - UpdateMessage: 강제 업데이트 메시지
  case forcedUpdateRequired(UpdateAlert)
  
  /// 선택 업데이트 필요
  /// - Parameters:
  ///   - UpdateMessage: 선택 업데이트 메시지
  case optionalUpdateRequired(UpdateAlert)
  
  /// 공지 얼럿 노출 필요
  /// - Parameters:
  ///   - NoticeInfo: 공지 사항 정보
  case notice(NoticeAlert)
}

/// 업데이트 메시지
public struct UpdateAlert: Sendable, Equatable {
  /// title: 업데이트 타이틀
  public let title: String
  
  /// message: 업데이트 메시지
  public let message: String
  
  /// alertDoneLinkURL: link URL
  public let alertDoneLinkURL: URL
  
  
  /// Creates an instance with the given alignment.
  /// - Parameters:
  ///   - message: 업데이트 메시지
  ///   - appstoreURL: 앱스토어 URL
  public init(title: String,
              message: String,
              alertDoneLinkURL: URL) {
    self.title = title
    self.message = message
    self.alertDoneLinkURL = alertDoneLinkURL
  }
}

/// 공지 얼럿 정보
public struct NoticeAlert: Sendable, Equatable {
  /// alert title: 얼럿 타이틀
  public let title: String
  
  /// alert message: 얼럿 메시지
  public let message: String
  
  /// alert isAppTerminated: 얼럿 확인 후 앱 종료 여부
  public let isAppTerminated: Bool
  
  /// alert doneURL: 확인 랜딩 URL
  public let doneURL: URL?
  
  
  /// Creates an instance with the given alignment.
  /// - Parameters:
  ///   - title: 얼럿 타이틀
  ///   - message: 얼럿 메시지
  ///   - isAppTerminated: 얼럿 확인 후 앱 종료 여부
  ///   - doneURL: 확인 랜딩 URL
  public init(title: String,
              message: String,
              isAppTerminated: Bool,
              doneURL: URL?) {
    self.title = title
    self.message = message
    self.isAppTerminated = isAppTerminated
    self.doneURL = doneURL
  }
}
