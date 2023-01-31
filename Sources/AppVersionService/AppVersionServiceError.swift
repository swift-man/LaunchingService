//
//  AppVersionServiceError.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

// MARK: - Enums
public enum AppVersionServiceError: Error {
  case invalidAppStoreURLString
  case notFoundAppStoreURLString
  case notFoundForceAppVersionKey
  case notFoundOptionalUpdateVersionKey
  case notFoundReleaseVersionNumber
  case unknown
}
