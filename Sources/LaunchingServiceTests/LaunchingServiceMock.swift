//
//  LaunchingServiceMock.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation
import LaunchingService

final class LaunchingServiceMock: LaunchingInteractable, Sendable {
  let releaseVersion: String
  let launching: Launching
  
  init(releaseVersion: String,
       launching: Launching) {
    self.releaseVersion = releaseVersion
    self.launching = launching
  }
  
  func fetchAppUpdateStatus(keyStore: LaunchingServiceKeyStore = LaunchingServiceKeyStore()) async throws -> AppUpdateStatus {
    return compare(releaseVersion: releaseVersion, launching: launching)
  }
}
