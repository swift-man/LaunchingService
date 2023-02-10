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
