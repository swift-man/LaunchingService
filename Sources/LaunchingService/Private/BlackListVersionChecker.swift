//
//  BlackListVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class BlackListVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> AppUpdateStatus {
    
    if launching.blackListVersions.contains(where: { $0.appVersionCompare(releaseVersionNumber) == .orderedSame }) {
      return .forcedUpdateRequired(message: launching.forceUpdate.message,
                                   appstoreURL: launching.appStoreURL)
    }
    
    return .valid
  }
}
