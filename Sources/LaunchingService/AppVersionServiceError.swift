//
//  AppVersionServiceError.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

// MARK: - Enums
public enum AppVersionServiceError: Equatable, LocalizedError, Sendable {
  case invalidAppStoreURLString
  case notFoundAppStoreURLString
  case notFoundForceAppVersionKey
  case notFoundOptionalUpdateVersionKey
  case notFoundReleaseVersionNumber
  case unknown
  
  public var errorDescription: String? {
    switch self {
    case .invalidAppStoreURLString:
      return "Invalid AppStoreURLString to nil."
    case .notFoundAppStoreURLString:
      return "Unknown user firebase remoteConfig Key (AppStore URL)"
    case .notFoundForceAppVersionKey:
      return "Unknown user firebase remoteConfig Key (Force App Version)"
    case .notFoundOptionalUpdateVersionKey:
      return "Unknown user firebase remoteConfig Key (Optional Update Version)"
    case .notFoundReleaseVersionNumber:
      return "Unknown user Bundle.main - Release Version Number"
    case .unknown:
      return "Unknown"
    }
  }
}
