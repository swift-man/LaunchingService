//
//  RemoteConfigForceUpdateParser.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import FirebaseRemoteConfig

final class RemoteConfigForceUpdateParser: Sendable {
  let keyStore: RemoteConfigRegisterdKeys
  
  init(keyStore: RemoteConfigRegisterdKeys) {
    self.keyStore = keyStore
  }
  
  func parseAppUpdateInfo() throws -> AppUpdateInfo {
    return AppUpdateInfo(version: try parseForceUpdateAppVersionKey(),
                         alertTitle: forceUpdateTitle,
                         alertMessage: forceUpdateMessage,
                         alertDoneLinkURL: try parseForceDoneLinkURL())
  }
  
  var parseBlackListVersions: [String] {
    guard
      let blackListVersionString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceUpdateKeys.blackListVersionsKey)
        .stringValue
    else {
      return []
    }
    
    return blackListVersionString
      .split(separator: ",")
      .map { String($0) }
  }
  
  private func parseForceDoneLinkURL() throws -> URL {
    guard
      let urlString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceUpdateKeys.alertDoneLinkURLKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundLinkURLKey
    }
    
    guard let url = URL(string: urlString) else {
      throw LaunchingServiceError.invalidLinkURLValue
    }
    
    return url
  }

  private func parseForceUpdateAppVersionKey() throws -> String {
    guard
      let forceUpdateAppVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceUpdateKeys.appVersionKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundForceUpdateAppVersionKey
    }
    
    return forceUpdateAppVersion
  }
  
  private var forceUpdateTitle: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.forceUpdateKeys.alertTitleKey)
      .stringValue ?? ""
  }
  
  private var forceUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.forceUpdateKeys.alertMessageKey)
      .stringValue ?? ""
  }
}
