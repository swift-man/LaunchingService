//
//  RemoteConfigForceUpdateParser.swift
//  
//
//  Created by SwiftMan on 2023/02/06.
//

import Foundation

final class RemoteConfigForceUpdateParser: Sendable {
  private let keyStore: RemoteConfigRegisterdKeys
  private let valueProvider: any RemoteConfigValueProviding
  
  init(keyStore: RemoteConfigRegisterdKeys,
       valueProvider: any RemoteConfigValueProviding = FirebaseRemoteConfigClient()) {
    self.keyStore = keyStore
    self.valueProvider = valueProvider
  }
  
  func parseAppUpdateInfo() -> AppUpdateInfo {
    guard let forceDoneLinkURL = parseForceDoneLinkURL() else {
      return .inactiveForceUpdate
    }

    return AppUpdateInfo(version: parseForceUpdateAppVersion() ?? "",
                         alertTitle: forceUpdateTitle,
                         alertMessage: forceUpdateMessage,
                         alertDoneLinkURL: forceDoneLinkURL)
  }
  
  func parseBlackListVersions() -> [String] {
    guard parseForceDoneLinkURL() != nil else { return [] }

    let blackListVersionString = valueProvider
      .stringValue(forKey: keyStore.forceUpdateKeys.blackListVersionsKey)
    
    return blackListVersionString
      .split(separator: ",")
      .map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
      .filter { !$0.isEmpty }
  }
  
  private func parseForceDoneLinkURL() -> URL? {
    guard let urlString = valueProvider
      .stringValue(forKey: keyStore.forceUpdateKeys.alertDoneLinkURLKey)
      .nilIfBlank
    else { return nil }

    return URL(string: urlString)
  }

  private func parseForceUpdateAppVersion() -> String? {
    valueProvider
      .stringValue(forKey: keyStore.forceUpdateKeys.appVersionKey)
      .nilIfBlank
  }
  
  private var forceUpdateTitle: String {
    valueProvider.stringValue(forKey: keyStore.forceUpdateKeys.alertTitleKey)
  }
  
  private var forceUpdateMessage: String {
    valueProvider.stringValue(forKey: keyStore.forceUpdateKeys.alertMessageKey)
  }
}

private extension AppUpdateInfo {
  static var inactiveForceUpdate: AppUpdateInfo {
    AppUpdateInfo(version: "",
                  alertTitle: "",
                  alertMessage: "",
                  alertDoneLinkURL: URL(string: "about:blank")!)
  }
}
