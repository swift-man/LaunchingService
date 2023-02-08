//
//  RemoteConfigParser.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import FirebaseRemoteConfig

final class RemoteConfigParser: Sendable {
  let keyStore: LaunchingServiceKeyStore
  
  init(keyStore: LaunchingServiceKeyStore) {
    self.keyStore = keyStore
  }
  
  func parse() throws -> Launching {
    let launching: Launching
    do {
      launching = Launching(forceUpdate: UpdateInfo(version: try parseForceUpdateAppVersionKey(),
                                                    message: forceUpdateMessage),
                            optionalUpdate: UpdateInfo(version: try parseOptionalUpdateAppVersion(),
                                                       message: optionalUpdateMessage),
                            blackListVersions: parseBlackListVersions,
                            appStoreURL: try parseAppStoreURL())
    } catch {
      throw error
    }
    
    return launching
  }
  
  private func parseAppStoreURL() throws -> URL {
    guard
      let appStoreURLString = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.appStoreURLKey)
        .stringValue
    else {
      throw LaunchingServiceError.notFoundAppStoreURLKey
    }
    
    guard let appStoreURL = URL(string: appStoreURLString) else {
      throw LaunchingServiceError.invalidAppStoreURLValue
    }
    
    return appStoreURL
  }
  
  private func parseForceUpdateAppVersionKey() throws -> String {
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
  
  private func parseOptionalUpdateAppVersion() throws -> String {
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
  
  private var forceUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.forceUpdateMessageKey)
      .stringValue ?? ""
  }
  
  private var optionalUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateMessageKey)
      .stringValue ?? ""
  }
  
  private var parseBlackListVersions: [String] {
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
