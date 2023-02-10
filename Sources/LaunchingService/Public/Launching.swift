//
//  Launching.swift
//  
//
//  Created by SwiftMan on 2023/02/08.
//

import Foundation

public struct Launching: Sendable {
  public let forceUpdate: AppUpdateInfo
  public let optionalUpdate: AppUpdateInfo
  public let blackListVersions: [String]
  public let appStoreURL: URL
  public let notice: NoticeInfo?
  
  public init(forceUpdate: AppUpdateInfo,
              optionalUpdate: AppUpdateInfo,
              blackListVersions: [String],
              appStoreURL: URL,
              notice: NoticeInfo?) {
    self.forceUpdate = forceUpdate
    self.optionalUpdate = optionalUpdate
    self.blackListVersions = blackListVersions
    self.appStoreURL = appStoreURL
    self.notice = notice
  }
}

public struct AppUpdateInfo: Sendable {
  public let version: String
  public let message: String
  
  public init(version: String, message: String) {
    self.version = version
    self.message = message
  }
}
