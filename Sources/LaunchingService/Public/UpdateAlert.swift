//
//  UpdateAlert.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation

/// 업데이트 메시지
public struct UpdateAlert: Sendable, Equatable {
  /// message: 업데이트 메시지
  public let message: String
  
  /// appstoreURL: 앱스토어 URL
  public let appstoreURL: URL
  
  public init(message: String, appstoreURL: URL) {
    self.message = message
    self.appstoreURL = appstoreURL
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
  
  /// alert doneURL: 확인 후 랜딩 URL
  public let doneURL: URL?
  
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
