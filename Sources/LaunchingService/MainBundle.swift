//
//  MainBundle.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

public class MainBundle {
  public static var releaseVersionNumber: String? {
    return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  public static var buildVersionNumber: String? {
    return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
  }
}
