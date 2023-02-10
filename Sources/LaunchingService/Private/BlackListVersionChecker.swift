//
//  BlackListVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class BlackListVersionChecker: Sendable {
  func compare(releaseVersion: String,
               launching: Launching) -> AppUpdateStatus {
    
    if launching.blackListVersions.contains(where: { $0.appVersionCompare(releaseVersion) == .orderedSame }) {
      let updateMessage = UpdateInfo(message: launching.forceUpdate.message,
                                     appstoreURL: launching.appStoreURL)
      return .forcedUpdateRequired(updateMessage)
    }
    
    return .valid
  }
}
