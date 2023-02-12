//
//  LaunchingServiceMock.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation
import LaunchingService

@MainActor
final class LaunchingServiceMock: LaunchingInteractable, Sendable {
  let releaseVersion: String
  let launching: Launching
  
  init(releaseVersion: String,
       launching: Launching) {
    self.releaseVersion = releaseVersion
    self.launching = launching
  }
  
  func fetchAppUpdateStatus(keyStore: RemoteConfigRegisterdKeys) async throws -> AppUpdateStatus {
    return compare(releaseVersion: releaseVersion, launching: launching)
  }
}

extension UpdateAlert {
  static let mock = UpdateAlert(title: "", message: "", alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!)
}
