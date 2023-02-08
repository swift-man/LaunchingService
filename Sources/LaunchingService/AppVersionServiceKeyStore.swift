//
//  AppVersionServiceKeyStore.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

public struct AppVersionServiceKeyStore: Sendable {
  let appStoreURLKey: String
  let forceAppVersionKey: String
  let forceUpdateMessageKey: String
  let optionalUpdateMessageKey: String
  let optionalUpdateVersionKey: String
  let blackListVersionsKey: String
  
  public init(appStoreURLKey: String = "appStoreURLString",
              forceAppVersionKey: String = "forceAppVersion",
              forceUpdateMessageKey: String = "forceUpdateMessage",
              optionalUpdateMessageKey: String = "optionalUpdateMessage",
              optionalUpdateVersionKey: String = "optionalUpdateVersion",
              blackListVersionsKey: String = "blackListVersions") {
    self.appStoreURLKey = appStoreURLKey
    self.forceAppVersionKey = forceAppVersionKey
    self.forceUpdateMessageKey = forceUpdateMessageKey
    self.optionalUpdateMessageKey = optionalUpdateMessageKey
    self.optionalUpdateVersionKey = optionalUpdateVersionKey
    self.blackListVersionsKey = blackListVersionsKey
  }
}
