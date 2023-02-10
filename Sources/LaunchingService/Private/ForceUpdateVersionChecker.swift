//
//  ForceUpdateVersionChecker.swift
//
//
//  Created by SwiftMan on 2023/01/28.
//

import Foundation

final class ForceUpdateVersionChecker: Sendable {
  func compare(releaseVersion: String,
               launching: Launching) -> AppUpdateStatus {
    if !launching.forceUpdate.version.isEmpty {
      switch releaseVersion.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame, .orderedDescending:
        return .valid
      case .orderedAscending:
        let alert = UpdateAlert(message: launching.forceUpdate.message,
                                appstoreURL: launching.appStoreURL)
        return .forcedUpdateRequired(alert)
      }
    }
    
    return .valid
  }
}
