//
//  AppVersionService.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class AppVersionService: Sendable {
  func releaseVersionNumber() throws -> String {
    guard
      let releaseVersionNumber = MainBundle.releaseVersionNumber, !releaseVersionNumber.isEmpty
    else {
      throw AppVersionServiceError.notFoundReleaseVersionNumber
    }
    
    return releaseVersionNumber
  }
}
