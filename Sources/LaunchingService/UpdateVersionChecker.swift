//
//  UpdateVersionChecker.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class UpdateVersionChecker: Sendable {
  func compare(releaseVersionNumber: String,
               launching: Launching) -> AppUpdateStatus {
    let forceChecker = ForceUpdateVersionChecker()
    let forceUpdateState = forceChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                launching: launching)
    
    if forceUpdateState == .valid {
      let optionalChecker = OptionalUpdateVersionChecker()
      let optionalUpdateState = optionalChecker.compare(releaseVersionNumber: releaseVersionNumber, launching: launching)
      
      return optionalUpdateState
    }
    
    return .valid
  }
}
