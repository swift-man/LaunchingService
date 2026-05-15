//
//  RemoteConfigOptionalUpdateParser.swift
//  
//
//  Created by SwiftMan on 2023/02/12.
//

import Foundation

final class RemoteConfigOptionalUpdateParser: Sendable {
  private let keyStore: RemoteConfigRegisterdKeys
  private let valueProvider: any RemoteConfigValueProviding
  
  init(keyStore: RemoteConfigRegisterdKeys,
       valueProvider: any RemoteConfigValueProviding = FirebaseRemoteConfigClient()) {
    self.keyStore = keyStore
    self.valueProvider = valueProvider
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
    return valueProvider
      .stringValue(forKey: keyStore.optionalUpdateKeys.appVersionKey)
      .nilIfBlank
  }
  
  private func parseOptionalDoneLinkURL() -> URL? {
    guard let urlString = valueProvider
      .stringValue(forKey: keyStore.optionalUpdateKeys.alertDoneLinkURLKey)
      .nilIfBlank
    else { return nil }

    return URL(string: urlString)
  }
  
  private var optionalUpdateTitle: String {
    valueProvider.stringValue(forKey: keyStore.optionalUpdateKeys.alertTitleKey)
  }
  
  private var optionalUpdateMessage: String {
    valueProvider.stringValue(forKey: keyStore.optionalUpdateKeys.alertMessageKey)
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
