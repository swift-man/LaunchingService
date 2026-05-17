// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "LaunchingService",
  platforms: [
    .iOS(.v15),
    .macOS(.v12),
    .tvOS(.v15),
    .watchOS(.v8),
  ],
  products: [
    .library(
      name: "LaunchingService",
      targets: ["LaunchingService"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "12.13.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", "1.4.0"..<"1.12.0"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "LaunchingService",
      dependencies: [
        .product(name: "FirebaseRemoteConfig", package: "firebase-ios-sdk"),
        .product(name: "Dependencies", package: "swift-dependencies"),
      ]),
    .testTarget(
      name: "LaunchingServiceTests",
      dependencies: [
        "LaunchingService"
      ]),
  ]
)
