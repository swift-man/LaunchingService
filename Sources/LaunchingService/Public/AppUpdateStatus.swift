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
  ///   - message: 강제 업데이트 메시지
  ///   - appstoreURL: 앱스토어 URL
  case forcedUpdateRequired(message: String, appstoreURL: URL)
  
  /// 선택 업데이트 필요
  /// - Parameters:
  ///   - message: 선택 업데이트 메시지
  ///   - appstoreURL: 앱스토어 URL
  case optionalUpdateRequired(message: String, appstoreURL: URL)
}
