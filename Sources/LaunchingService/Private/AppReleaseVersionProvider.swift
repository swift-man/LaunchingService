//
//  AppReleaseVersionProvider.swift
//
//
//  Created by SwiftMan on 2023/01/31.
//

protocol AppReleaseVersionProviding: Sendable {
  func releaseVersion() throws -> String
}

struct MainBundleReleaseVersionProvider: AppReleaseVersionProviding {
  func releaseVersion() throws -> String {
    try MainBundle().releaseVersion()
  }
}
