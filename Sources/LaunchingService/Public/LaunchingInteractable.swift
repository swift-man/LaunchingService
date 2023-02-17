//
//  LaunchingInteractable.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation

@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public protocol LaunchingInteractable: AnyObject, Sendable {
  func fetchAppUpdateStatus() async throws -> AppUpdateStatus
}

extension LaunchingInteractable {
  @available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
  public func compare(releaseVersion: String, launching: Launching) -> AppUpdateStatus {
    var updateState = AppUpdateStatusChecker().compare(releaseVersion: releaseVersion,
                                                       launching: launching)
    
    if updateState == .valid {
      updateState = NoticeChecker().compare(launching: launching)
    }
    
    return updateState
  }
}
