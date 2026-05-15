//
//  RemoteConfigClient.swift
//
//
//  Created by SwiftMan on 2023/01/31.
//

import FirebaseRemoteConfig

protocol RemoteConfigValueProviding: Sendable {
  func stringValue(forKey key: String) -> String
  func boolValue(forKey key: String) -> Bool
}

protocol RemoteConfigFetching: Sendable {
  func fetchAndActivate() async throws
}

protocol RemoteConfigClient: RemoteConfigFetching, RemoteConfigValueProviding {
}

struct FirebaseRemoteConfigClient: RemoteConfigClient {
  func fetchAndActivate() async throws {
    let remoteConfig = RemoteConfig.remoteConfig()
    _ = try await remoteConfig.fetchAndActivate()
  }

  func stringValue(forKey key: String) -> String {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: key)
      .stringValue
  }

  func boolValue(forKey key: String) -> Bool {
    RemoteConfig
      .remoteConfig()
      .configValue(forKey: key)
      .boolValue
  }
}
