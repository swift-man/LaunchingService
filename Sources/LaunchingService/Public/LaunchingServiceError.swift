//
//  LaunchingServiceError.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

/// Error cases exposed by ``LaunchingService``.
///
/// The current Remote Config parser treats missing keys, invalid URLs, and invalid
/// dates as inactive feature states. With the default service implementation,
/// ``LaunchingServiceError/invalidMainBundleReleaseVersionNumber`` is thrown when
/// the app release version cannot be read from the main bundle. The remaining
/// cases are retained for public API compatibility.
@available(iOS 15.0, macOS 12, tvOS 15, watchOS 8.0, *)
public enum LaunchingServiceError: Error, Equatable, Sendable {
  
  /// Legacy compatibility case for invalid Remote Config URL values.
  @available(*, deprecated, message: "Remote Config URL parsing failures are treated as inactive feature states.")
  case invalidLinkURLValue
  
  /// Legacy compatibility case for missing Remote Config link URL keys.
  @available(*, deprecated, message: "Missing Remote Config link URL keys are treated as inactive feature states.")
  case notFoundLinkURLKey
  
  /// Legacy compatibility case for missing force update version keys.
  @available(*, deprecated, message: "Missing force update version keys are treated as inactive feature states.")
  case notFoundForceUpdateAppVersionKey
  
  /// Legacy compatibility case for missing optional update version keys.
  @available(*, deprecated, message: "Missing optional update version keys are treated as inactive feature states.")
  case notFoundOptionalUpdateAppVersionKey
  
  /// The main bundle does not contain a non-empty release version number.
  case invalidMainBundleReleaseVersionNumber
  
  /// Legacy compatibility case for unknown errors.
  @available(*, deprecated, message: "The current LaunchingService implementation does not throw unknown errors.")
  case unknown
}
