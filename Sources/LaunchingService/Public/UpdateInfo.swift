//
//  UpdateInfo.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation

/// 업데이트 메시지
public struct UpdateInfo: Sendable, Equatable {
  /// message: 업데이트 메시지
  public let message: String
  
  /// appstoreURL: 앱스토어 URL
  public let appstoreURL: URL
}
