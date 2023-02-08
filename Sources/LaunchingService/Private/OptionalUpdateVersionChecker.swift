//
//  OptionalUpdateVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class OptionalUpdateVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> AppUpdateStatus {
    if !launching.optionalUpdate.version.isEmpty {
      switch releaseVersionNumber.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame, .orderedDescending:
        return .valid
      case .orderedAscending:
        return .optionalUpdateRequired(message: launching.optionalUpdate.message,
                                       appstoreURL: launching.appStoreURL)
      }
    }
    
    return .valid
  }
}
