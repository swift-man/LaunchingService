// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppVersionService",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
  ],
  products: [
    .library(
      name: "AppVersionService",
      targets: ["AppVersionService"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.4.0"),
  ],
  targets: [
    .target(
      name: "AppVersionService",
      dependencies: [
        .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
      ]),
  ]
)
