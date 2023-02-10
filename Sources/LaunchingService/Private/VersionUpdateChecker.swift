//
//  VersionUpdateChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class VersionUpdateChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> AppUpdateStatus {
    let forceChecker = ForceUpdateVersionChecker()
    var appUpdateState = forceChecker.compare(releaseVersion: releaseVersionNumber,
                                              launching: launching)
    
    if appUpdateState == .valid {
      let blackListVersionChecker = BlackListVersionChecker()
      appUpdateState = blackListVersionChecker.compare(releaseVersion: releaseVersionNumber,
                                                       launching: launching)
      
      if appUpdateState == .valid {
        let optionalChecker = OptionalUpdateVersionChecker()
        appUpdateState = optionalChecker.compare(releaseVersion: releaseVersionNumber,
                                                 launching: launching)
      }
    }
    
    return appUpdateState
  }
}
