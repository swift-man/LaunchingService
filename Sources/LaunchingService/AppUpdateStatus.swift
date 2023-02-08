//
//  AppUpdateStatus.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

// MARK: - Enums
public enum AppUpdateStatus: Equatable, Sendable {
  case valid
  case forcedUpdateRequired(message: String, appstoreURL: URL)
  case optionalUpdateRequired(message: String, appstoreURL: URL)
}
