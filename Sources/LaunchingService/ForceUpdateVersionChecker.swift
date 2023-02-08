//
//  ForceUpdateVersionChecker.swift
//
//
//  Created by SwiftMan on 2023/01/28.
//

import Foundation

final class ForceUpdateVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> ResultAppVersion {
    if !launching.forceUpdate.version.isEmpty {
      switch releaseVersionNumber.appVersionCompare(launching.forceUpdate.version) {
      case .orderedSame:
        return ResultAppVersion.success
      case .orderedAscending:
        return .forcedUpdateRequired(message: launching.forceUpdate.message,
                                     appstoreURL: launching.appStoreURL)
      case .orderedDescending:
        return ResultAppVersion.success
      }
    }
    
    return ResultAppVersion.success
  }
}
