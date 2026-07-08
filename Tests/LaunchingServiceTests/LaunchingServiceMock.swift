//
//  LaunchingServiceMock.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Foundation
@testable import LaunchingService

@MainActor
final class LaunchingServiceMock: LaunchingInteractable, Sendable {
  let releaseVersion: String
  let launching: Launching
  let dateProvider: any DateProviding
  
  init(releaseVersion: String,
       launching: Launching,
       dateProvider: any DateProviding) {
    self.releaseVersion = releaseVersion
    self.launching = launching
    self.dateProvider = dateProvider
  }
  
  func fetchAppUpdateStatus() async throws -> AppUpdateStatus {
    return LaunchingStatusComparator(dateProvider: dateProvider).compare(releaseVersion: releaseVersion,
                                                                         launching: launching)
  }
}

extension UpdateAlert {
  static let mock = UpdateAlert(title: "", message: "", alertDoneLinkURL: URL(string: "https://github.com/swift-man/LaunchingService")!)
}
