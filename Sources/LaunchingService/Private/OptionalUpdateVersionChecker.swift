//
//  OptionalUpdateVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class OptionalUpdateVersionChecker: Sendable {
  func compare(releaseVersion: String,
               launching: Launching) -> AppUpdateStatus {
    if !launching.optionalUpdate.version.isEmpty {
      switch releaseVersion.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame, .orderedDescending:
        return .valid
      case .orderedAscending:
        let updateMessage = UpdateInfo(message: launching.optionalUpdate.message,
                                       appstoreURL: launching.appStoreURL)
        return .optionalUpdateRequired(updateMessage)
      }
    }
    
    return .valid
  }
}
