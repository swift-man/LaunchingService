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
        let alert = UpdateAlert(title: launching.forceUpdate.alertTitle,
                                message: launching.forceUpdate.alertMessage,
                                alertDoneLinkURL: launching.forceUpdate.alertDoneLinkURL)
        return .forcedUpdateRequired(alert)
      }
    }
    
    return .valid
  }
}
