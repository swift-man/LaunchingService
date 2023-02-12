//
//  LaunchingInteractable.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation

public protocol LaunchingInteractable: AnyObject, Sendable {
  func fetchAppUpdateStatus() async throws -> AppUpdateStatus
}

extension LaunchingInteractable {
  public func compare(releaseVersion: String, launching: Launching) -> AppUpdateStatus {
    var updateState = VersionUpdateChecker().compare(releaseVersion: releaseVersion,
                                                     launching: launching)
    
    if updateState == .valid {
      updateState = NoticeChecker().compare(launching: launching)
    }
    
    return updateState
  }
}
