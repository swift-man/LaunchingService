# LaunchingService

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.6.1-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac_12|ios_15-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)  

---

## Google Firebase
### [FirebaseRemoteConfig](https://github.com/firebase/firebase-ios-sdk) Async/await wrapper.

## Feature
* [x] Force Version Checked Update
* [x] Optional Version Checked Update
* [x] BlackList Version
* [ ] Notice
  * [ ] startDate ~ endDate
  * [ ] message
  * [ ] optional
  * [ ] button URL Link


## API Call
```swift
let service = LaunchingService(keyStore: LaunchingServiceKeyStore())
let appUpdateState = try await service.fetchLaunchingConfig()
```

### API Response
```swift
public enum AppUpdateStatus: Equatable, Sendable {
  case valid
  case forcedUpdateRequired(message: String, appstoreURL: URL)
  case optionalUpdateRequired(message: String, appstoreURL: URL)
}
```

### API Error
```swift
public enum LaunchingServiceError: Error {
  case invalidAppStoreURLValue
  case notFoundAppStoreURLKey
  case notFoundForceUpdateAppVersionKey
  case notFoundOptionalUpdateAppVersionKey
  case invalidMainBundleReleaseVersionNumber
  case unknown
}
```

## Default Keys
![Image](https://drive.google.com/uc?export=view&id=1f2dRMrS9SuRiVWXolqrGLXiCvrpgcVQd)  

```swift
"appStoreURLKey"
"forceUpdateAppVersionKey" // (Optional Value)
"forceUpdateMessageKey" // (Optional Key, Value)
"optionalUpdateAppVersionKey" // (Optional Key, Value)
"optionalUpdateMessageKey" // (Optional Value)
"blackListVersionsKey" // (Optional Key, Value)
```

### Your Custom Keys
```swift
let keyStore = LaunchingServiceKeyStore(appStoreURLKey: #YourCustomKey#, ...)
let service = LaunchingService(keyStore: keyStore))
```


## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/swift-man/LaunchingService.git", .from: "0.6.0")
]
```

## Example Presentation Layer
[LaunchingView](https://github.com/swift-man/LaunchingView) - SwiftUI
