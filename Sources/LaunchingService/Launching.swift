//
//  Launching.swift
//  
//
//  Created by SwiftMan on 2023/02/08.
//

import Foundation

struct Launching: Sendable {
  let forceUpdate: UpdateInfo
  let optionalUpdate: UpdateInfo
  let blackListVersions: [String]
  let appStoreURL: URL
}

struct UpdateInfo: Sendable {
  let version: String
  let message: String
}
