//
//  ForceUpdateVersionChecker.swift
//
//
//  Created by SwiftMan on 2023/01/28.
//

import Foundation

final class ForceUpdateVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> AppUpdateStatus {
    if !launching.forceUpdate.version.isEmpty {
      switch releaseVersionNumber.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame, .orderedDescending:
        return .valid
      case .orderedAscending:
        return .forcedUpdateRequired(message: launching.forceUpdate.message,
                                     appstoreURL: launching.appStoreURL)
      }
    }
    
    return .valid
  }
}
