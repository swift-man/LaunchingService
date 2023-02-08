//
//  RemoteConfigParser.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation
import FirebaseRemoteConfig

struct Launching: Sendable {
  let forceUpdate: ForceUpdate
  let optionalUpdate: OptionalUpdate
  let blackListVersions: [String]
  let appStoreURL: URL
}

struct ForceUpdate: Sendable {
  let version: String
  let message: String
}

struct OptionalUpdate: Sendable {
  let version: String
  let message: String
}

final class RemoteConfigParser: Sendable {
  let keyStore: AppVersionServiceKeyStore
  
  init(keyStore: AppVersionServiceKeyStore) {
    self.keyStore = keyStore
  }
  
  func parse() throws -> Launching {
    let launching: Launching
    do {
      launching = Launching(forceUpdate: ForceUpdate(version: try parseForceUpdateAppVersion(),
                                                     message: forceUpdateMessage),
                            optionalUpdate: OptionalUpdate(version: try parseOptionalUpdateVersion(),
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
      throw AppVersionServiceError.notFoundAppStoreURLString
    }
    
    guard let appStoreURL = URL(string: appStoreURLString) else {
      throw AppVersionServiceError.invalidAppStoreURLString
    }
    
    return appStoreURL
  }
  
  private func parseForceUpdateAppVersion() throws -> String {
    guard
      let forceUpdateAppVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceAppVersionKey)
        .stringValue
    else {
      throw AppVersionServiceError.notFoundForceAppVersionKey
    }

    return forceUpdateAppVersion
  }
  
  private func parseOptionalUpdateVersion() throws -> String {
    guard
      let optionalUpdateVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.optionalUpdateVersionKey)
        .stringValue
    else {
      throw AppVersionServiceError.notFoundOptionalUpdateVersionKey
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
