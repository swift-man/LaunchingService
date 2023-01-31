//
//  ResultAppVersion.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

// MARK: - Enums
public enum ResultAppVersion: Equatable {
  case success
  case forcedUpdateRequired(message: String, appstoreURL: URL)
  case optionalUpdateRequired(message: String, appstoreURL: URL)
}
