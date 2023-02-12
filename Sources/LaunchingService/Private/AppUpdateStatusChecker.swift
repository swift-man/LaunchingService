//
//  AppUpdateStatusChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class AppUpdateStatusChecker: Sendable {
  func compare(releaseVersion: String,
               launching: Launching) -> AppUpdateStatus {
    let forceChecker = ForceUpdateVersionChecker()
    var appUpdateState = forceChecker.compare(releaseVersion: releaseVersion,
                                              launching: launching)
    
    if appUpdateState == .valid {
      let blackListVersionChecker = BlackListVersionChecker()
      appUpdateState = blackListVersionChecker.compare(releaseVersion: releaseVersion,
                                                       launching: launching)
      
      if appUpdateState == .valid {
        let optionalChecker = OptionalUpdateVersionChecker()
        appUpdateState = optionalChecker.compare(releaseVersion: releaseVersion,
                                                 launching: launching)
      }
    }
    
    return appUpdateState
  }
}
