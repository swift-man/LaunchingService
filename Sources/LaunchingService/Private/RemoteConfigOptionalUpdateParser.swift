//
//  RemoteConfigOptionalUpdateParser.swift
//  
//
//  Created by SwiftMan on 2023/02/12.
//

import Foundation
import FirebaseRemoteConfig

final class RemoteConfigOptionalUpdateParser: Sendable {
  let keyStore: RemoteConfigRegisterdKeys
  
  init(keyStore: RemoteConfigRegisterdKeys) {
    self.keyStore = keyStore
  }
  
  func parseAppUpdateInfo() -> AppUpdateInfo {
    guard
      let optionalUpdateVersion = parseOptionalUpdateAppVersion(),
      let optionalDoneLinkURL = parseOptionalDoneLinkURL()
    else {
      return .inactiveOptionalUpdate
    }

    return AppUpdateInfo(version: optionalUpdateVersion,
                         alertTitle: optionalUpdateTitle,
                         alertMessage: optionalUpdateMessage,
                         alertDoneLinkURL: optionalDoneLinkURL)
  }
  
  private func parseOptionalUpdateAppVersion() -> String? {
    return RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.appVersionKey)
      .stringValue
      .nilIfBlank
  }
  
  private func parseOptionalDoneLinkURL() -> URL? {
    guard let urlString = RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.alertDoneLinkURLKey)
      .stringValue
      .nilIfBlank
    else { return nil }

    return URL(string: urlString)
  }
  
  private var optionalUpdateTitle: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.alertTitleKey)
      .stringValue
  }
  
  private var optionalUpdateMessage: String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: keyStore.optionalUpdateKeys.alertMessageKey)
      .stringValue
  }
}

private extension AppUpdateInfo {
  static var inactiveOptionalUpdate: AppUpdateInfo {
    AppUpdateInfo(version: "",
                  alertTitle: "",
                  alertMessage: "",
                  alertDoneLinkURL: URL(string: "about:blank")!)
  }
}
