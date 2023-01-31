//
//  Bundle+.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

extension Bundle {
  public var releaseVersionNumber: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  public var buildVersionNumber: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }
}
