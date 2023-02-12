//
//  RemoteConfigOptionalUpdateParser.swift
//  
//
//  Created by SwiftMan on 2023/02/12.
//

import FirebaseRemoteConfig

final class RemoteConfigOptionalUpdateParser: Sendable {
  let keyStore: RemoteConfigRegisterdKeys
  
  init(keyStore: RemoteConfigRegisterdKeys) {
    self.keyStore = keyStore
  }
  
  func parseAppUpdateInfo() throws -> AppUpdateInfo {
    return AppUpdateInfo(version: try parseOptionalUpdateAppVersion(),
                         alertTitle: optionalUpdateTitle,
                         alertMessage: optionalUpdateMessage,
                         alertDoneLinkURL: try parseOptionalDoneLinkURL())
  }
  
  private func parseOptionalUpdateAppVersion() throws -> String {
    guard
      let optionalUpdateVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.optionalUpdateKeys.appVersionKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundOptionalUpdateAppVersionKey
    }
    
    return optionalUpdateVersion
  }
  
  private func parseOptionalDoneLinkURL() throws -> URL {
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
  
  private var optionalUpdateTitle: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.alertTitleKey)
      .stringValue ?? ""
  }
  
  private var optionalUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.alertMessageKey)
      .stringValue ?? ""
  }
}
