//
//  MainBundle.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public class MainBundle {
  public var releaseVersionNumber: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  public var buildVersionNumber: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
  }
  
  func releaseVersion() throws -> String {
    guard
      let releaseVersion = releaseVersionNumber, !releaseVersion.isEmpty
    else {
      throw LaunchingServiceError.invalidMainBundleReleaseVersionNumber
    }
    
    return releaseVersion
  }
}
