//
//  LaunchingServiceError.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

/// Error types when `Not found` / `invalid` typed RemoteConfig Keys
public enum LaunchingServiceError: Error, Equatable, Sendable {
  
  /// Invalid AppStoreURLValue to nil.
  case invalidAppStoreURLValue
  
  /// Unknown user firebase remoteConfig Key `AppStore URL`
  case notFoundAppStoreURLKey
  
  /// Unknown user firebase remoteConfig Key `Force Update Version`
  case notFoundForceUpdateAppVersionKey
  
  /// Unknown user firebase remoteConfig Key `Optional Update Version`
  case notFoundOptionalUpdateAppVersionKey
  
  /// Unknown user `Bundle.main` - Release Version Number
  case invalidMainBundleReleaseVersionNumber
  
  /// Unknown
  case unknown
}
