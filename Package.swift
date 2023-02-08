// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LaunchingService",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    .library(
      name: "LaunchingService",
      targets: ["LaunchingService"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.4.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "0.1.2"),
    .package(url: "https://github.com/pointfreeco/xctest-dynamic-overlay", from: "0.5.0"),
  ],
  targets: [
    .target(
      name: "LaunchingService",
      dependencies: [
        .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
        .product(name: "Dependencies", package: "swift-dependencies"),
        .product(name: "XCTestDynamicOverlay", package: "xctest-dynamic-overlay"),
      ]),
  ]
)
