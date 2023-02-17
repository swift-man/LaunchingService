//
//  LaunchingServiceError.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

/// Error types when `Not found` / `invalid` typed RemoteConfig Keys
@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public enum LaunchingServiceError: Error, Equatable, Sendable {
  
  /// Invalid LinkURLValue to nil.
  case invalidLinkURLValue
  
  /// Unknown user firebase remoteConfig Key `Link URL`
  case notFoundLinkURLKey
  
  /// Unknown user firebase remoteConfig Key `Force Update Version`
  case notFoundForceUpdateAppVersionKey
  
  /// Unknown user firebase remoteConfig Key `Optional Update Version`
  case notFoundOptionalUpdateAppVersionKey
  
  /// Unknown user `Bundle.main` - Release Version Number
  case invalidMainBundleReleaseVersionNumber
  
  /// Unknown
  case unknown
}
