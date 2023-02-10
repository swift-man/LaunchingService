//
//  NoticeInfo.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation

/// 공지 얼럿 정보
public struct NoticeInfo: Sendable, Equatable {
  /// alert title: 얼럿 타이틀
  public let title: String
  
  /// alert message: 얼럿 메시지
  public let message: String
  
  /// alert dateRange: 얼럿 노출 기간
  public let dateRange: ClosedRange<Date>
  
  /// alert isAppTerminated: 얼럿 확인 후 앱 종료 여부
  public let isAppTerminated: Bool
  
  /// alert doneURL: 확인 후 랜딩 URL
  public let doneURL: URL?
}
