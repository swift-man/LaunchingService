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
      let alert = UpdateAlert(title: launching.forceUpdate.alertTitle,
                              message: launching.forceUpdate.alertMessage,
                              alertDoneLinkURL: launching.forceUpdate.alertDoneLinkURL)
      return .forcedUpdateRequired(alert)
    }
    
    return .valid
  }
}
