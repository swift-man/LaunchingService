//
//  OptionalUpdateVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation
import FirebaseRemoteConfig
import Firebase

final class OptionalUpdateVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> ResultAppVersion {
    if !launching.optionalUpdate.version.isEmpty {
      switch releaseVersionNumber.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame:
        return ResultAppVersion.success
      case .orderedAscending:
        return .optionalUpdateRequired(message: launching.optionalUpdate.message,
                                       appstoreURL: launching.appStoreURL)
      case .orderedDescending:
        return ResultAppVersion.success
      }
    }
    
    return ResultAppVersion.success
  }
}
