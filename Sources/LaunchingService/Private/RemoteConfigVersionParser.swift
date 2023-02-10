//
//  RemoteConfigVersionParser.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import FirebaseRemoteConfig

final class RemoteConfigVersionParser: Sendable {
  let keyStore: LaunchingServiceKeyStore
  
  init(keyStore: LaunchingServiceKeyStore) {
    self.keyStore = keyStore
  }

  func parseForceUpdateAppVersionKey() throws -> String {
    guard
      let forceUpdateAppVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceUpdateAppVersionKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundForceUpdateAppVersionKey
    }
    
    return forceUpdateAppVersion
  }
  
  func parseOptionalUpdateAppVersion() throws -> String {
    guard
      let optionalUpdateVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.optionalUpdateAppVersionKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundOptionalUpdateAppVersionKey
    }
    
    return optionalUpdateVersion
  }
  
  var forceUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.forceUpdateMessageKey)
      .stringValue ?? ""
  }
  
  var optionalUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateMessageKey)
      .stringValue ?? ""
  }
  
  var parseBlackListVersions: [String] {
    guard
      let blackListVersionString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.blackListVersionsKey)
        .stringValue
    else {
      return []
    }
    
    return blackListVersionString
      .split(separator: ",")
      .map { String($0) }
  }
}
