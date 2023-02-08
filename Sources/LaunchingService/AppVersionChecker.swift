//
//  AppVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class AppVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> ResultAppVersion {
    let forceChecker = ForceUpdateVersionChecker()
    let forceUpdateState = forceChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                launching: launching)
    
    if forceUpdateState == .success {
      let optionalChecker = OptionalUpdateVersionChecker()
      let optionalUpdateState = optionalChecker.compare(releaseVersionNumber: releaseVersionNumber, launching: launching)
      
      return optionalUpdateState
    }
    
    return .success
  }
}
