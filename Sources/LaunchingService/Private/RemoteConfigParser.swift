//
//  File.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import FirebaseRemoteConfig

final class RemoteConfigParser: Sendable {
  func parse(keyStore: LaunchingServiceKeyStore) throws -> Launching {
    do {
      let versionParser = RemoteConfigVersionParser(keyStore: keyStore)
      let noticeParser = RemoteConfigNoticeParser(keyStore: keyStore)
      
      let forceUpdate = Launching.UpdateInfo(version: try versionParser.parseForceUpdateAppVersionKey(),
                                             message: versionParser.forceUpdateMessage)
      
      let optionalUpdate = Launching.UpdateInfo(version: try versionParser.parseOptionalUpdateAppVersion(),
                                                message: versionParser.optionalUpdateMessage)
      let appStoreURL = try parseAppStoreURL(keyStore: keyStore)
      let notice = noticeParser.parseNotice()
      
      return Launching(forceUpdate: forceUpdate,
                            optionalUpdate: optionalUpdate,
                            blackListVersions: versionParser.parseBlackListVersions,
                            appStoreURL: appStoreURL,
                            notice: notice)
    } catch {
      throw error
    }
  }
  
  private func parseAppStoreURL(keyStore: LaunchingServiceKeyStore) throws -> URL {
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
}
