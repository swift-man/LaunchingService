//
//  LaunchingInteractable.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Foundation

@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public protocol LaunchingInteractable: AnyObject, Sendable {
  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  ///
  /// - Returns: ``AppUpdateStatus`` - `valid`, `forcedUpdateRequired`, `optionalUpdateRequired`, `notice`
  /// - Throws: ``LaunchingServiceError``
  func fetchAppUpdateStatus() async throws -> AppUpdateStatus
}

extension LaunchingInteractable {
  @available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
  public func compare(releaseVersion: String, launching: Launching) -> AppUpdateStatus {
    var appStatus = AppUpdateStatusChecker().compare(releaseVersion: releaseVersion,
                                                     launching: launching)
    
    if appStatus == .valid {
      appStatus = NoticeChecker().compare(launching: launching)
    }
    
    return appStatus
  }
}
