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
      switch releaseVersion.appVersionCompare(launching.optionalUpdate.version) {
      case .orderedSame, .orderedDescending:
        return .valid
      case .orderedAscending:
        let alert = UpdateAlert(title: launching.optionalUpdate.alertTitle,
                                message: launching.optionalUpdate.alertMessage,
                                alertDoneLinkURL: launching.optionalUpdate.alertDoneLinkURL)
        return .optionalUpdateRequired(alert)
      }
    }
    
    return .valid
  }
}
