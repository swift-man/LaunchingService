//
//  AppVersionCheckService.swift
//
//
//  Created by SwiftMan on 2023/01/28.
//

import Foundation
import FirebaseRemoteConfig
import Firebase

class AppVersionCheckService {
  let keyStore: AppVersionServiceKeyStore
  
  init(keyStore: AppVersionServiceKeyStore) {
    self.keyStore = keyStore
  }
  
  func compareReleaseVersion() throws -> ResultAppVersion {
    let releaseVersionNumber = try releaseVersionNumber()
    let appStoreURL = try parseAppStoreURL()
    
    if let forceUpdateAppVersion = try parseForceUpdateAppVersion() {
      if let state = try parseForceUpdate(releaseVersionNumber: releaseVersionNumber,
                                          forceUpdateAppVersion: forceUpdateAppVersion,
                                          appStoreURL: appStoreURL) {
        return state
      }
    }
    
    if let optionalUpdateVersion = try parseOptionalUpdateVersion() {
      if let state = try parseOptionalUpdate(releaseVersionNumber: releaseVersionNumber,
                                             optionalUpdateVersion: optionalUpdateVersion,
                                             appStoreURL: appStoreURL) {
        return state
      }
    }
    
    return ResultAppVersion.success
  }
  
  private func releaseVersionNumber() throws -> String {
    guard
      let releaseVersionNumber = Bundle.main.releaseVersionNumber, !releaseVersionNumber.isEmpty
    else {
      throw AppVersionServiceError.notFoundReleaseVersionNumber
    }
    
    return releaseVersionNumber
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
  
  private func parseForceUpdateAppVersion() throws -> String? {
    guard
      let forceUpdateAppVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceAppVersionKey)
        .stringValue
    else {
      throw AppVersionServiceError.notFoundForceAppVersionKey
    }
    
    guard
      !forceUpdateAppVersion.isEmpty
    else {
      return nil
    }
    
    return forceUpdateAppVersion
  }
  
  private func parseForceUpdate(releaseVersionNumber: String,
                                forceUpdateAppVersion: String,
                                appStoreURL: URL) throws -> ResultAppVersion? {
    switch releaseVersionNumber.appVersionCompare(forceUpdateAppVersion) {
    case .orderedSame:
      break
    case .orderedAscending:
      let forceUpdateMessage = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.forceUpdateMessageKey)
        .stringValue ?? ""
      
      return .forcedUpdateRequired(message: forceUpdateMessage,
                                   appstoreURL: appStoreURL)
    case .orderedDescending:
      break
    }
    
    return nil
  }
  
  private func parseOptionalUpdateVersion() throws -> String? {
    guard
      let optionalUpdateVersion = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.optionalUpdateVersionKey)
        .stringValue
    else {
      throw AppVersionServiceError.notFoundOptionalUpdateVersionKey
    }
    
    guard
      !optionalUpdateVersion.isEmpty
    else {
      return nil
    }
    
    return optionalUpdateVersion
  }
  
  private func parseOptionalUpdate(releaseVersionNumber: String,
                                   optionalUpdateVersion: String,
                                   appStoreURL: URL) throws -> ResultAppVersion? {
    switch releaseVersionNumber.appVersionCompare(optionalUpdateVersion) {
    case .orderedSame:
      break
    case .orderedAscending:
      let optionalUpdateMessage = RemoteConfig
        .remoteConfig()
        .configValue(forKey: keyStore.optionalUpdateMessageKey)
        .stringValue ?? ""
      
      return .optionalUpdateRequired(message: optionalUpdateMessage,
                                     appstoreURL: appStoreURL)
    case .orderedDescending:
      break
    }
    
    return nil
  }
}
