//
//  AppVersionServiceKeyStore.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

public struct AppVersionServiceKeyStore {
  let appStoreURLKey: String
  let forceAppVersionKey: String
  let forceUpdateMessageKey: String
  let optionalUpdateMessageKey: String
  let optionalUpdateVersionKey: String
  
  public init(appStoreURLKey: String = "appStoreURLString",
              forceAppVersionKey: String = "iosForceAppVersion",
              forceUpdateMessageKey: String = "forceUpdateMessage",
              optionalUpdateMessageKey: String = "optionalUpdateMessage",
              optionalUpdateVersionKey: String = "iosOptionalUpdateVersion") {
    self.appStoreURLKey = appStoreURLKey
    self.forceAppVersionKey = forceAppVersionKey
    self.forceUpdateMessageKey = forceUpdateMessageKey
    self.optionalUpdateMessageKey = optionalUpdateMessageKey
    self.optionalUpdateVersionKey = optionalUpdateVersionKey
  }
}
