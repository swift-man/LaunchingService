# LaunchingService

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.8.0-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac_12|ios_15-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)  

---
## 강제 업데이트 / 선택 업데이트 / 공지사항을 유저에게 제공합니다.
### Process Plan
* Launch App
* Force Update
  * Check the forced update version
  * Check the blacklist update versions
* Optional Update
  * Check the optional update version
* Notice Alert
  * Check the notice alert presentation
* Launch ContentView

## Example Presentation Layer
[LaunchingView](https://github.com/swift-man/LaunchingView) - SwiftUI

## Google Firebase
### [FirebaseRemoteConfig](https://github.com/firebase/firebase-ios-sdk) Async/await wrapper.

## Feature
* [x] Force Version Checked Update
* [x] Optional Version Checked Update
* [x] BlackList Version
* [x] Notice
  * [x] startDate ~ endDate
  * [x] message
  * [x] isAppTerminated
  * [x] button URL Link

## API Call
```swift
let service = LaunchingService()
let appUpdateState = try await service.fetchAppStatus(keyStore: LaunchingServiceKeyStore())
```

### API Response
```swift
/// Result types App Update Status
public enum AppUpdateStatus: Equatable, Sendable {
  /// 유효
  case valid
  
  /// 강제 업데이트 필요
  /// - Parameters:
  ///   - UpdateMessage: 강제 업데이트 메시지
  case forcedUpdateRequired(UpdateAlert)
  
  /// 선택 업데이트 필요
  /// - Parameters:
  ///   - UpdateMessage: 선택 업데이트 메시지
  case optionalUpdateRequired(UpdateAlert)
  
  /// 공지 얼럿 노출 필요
  /// - Parameters:
  ///   - NoticeInfo: 공지 사항 정보
  case notice(NoticeAlert)
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
"forceUpdateAlertDoneLinkURLKey"
"forceUpdateAppVersionKey" // (Optional Value)
"forceUpdateMessageKey" // (Optional Key, Value)
"optionalUpdateAppVersionKey" // (Optional Key, Value)
"optionalUpdateMessageKey" // (Optional Value)
"blackListVersionsKey" // (Optional Key, Value)
...
```

### Your Custom Keys
```swift
import Dependencies

extension RemoteConfigRegisterdKeys: DependencyKey {
  public static var liveValue = RemoteConfigRegisterdKeys(
    forceUpdateKeys: #...#
    optionalUpdateKeys: #...#
    noticeKeys : #...#
  )
}
```

## BlackList
If the app is a blacklisted version, it is force updated.
```
1.0.0, 1.2.0, 2.0.0
```

## Notice
### DateFormat
```
yyyy-MM-ddTHH:mm:ssZ
```

* noticeStartDateKey
  * value: String (ex: 2023-02-12T02:22:40Z) // UTC
  
* noticeEndDateKey
 * value: String (ex: 2023-02-14T05:12:55Z) // UTC
 
### Title, Message
* noticeAlertTitleKey
  * value: String
* noticeAlertMessageKey
  * value: String

### URL Landing
* noticeAlertDoneURLKey
  * value: String (ex: https://https://github.com/swift-man/LaunchingService/README.md)

### App Terminate
* noticeAlertDismissedTerminateKey
  * value: Bool

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/swift-man/LaunchingService.git", .from: "0.8.0")
]
```
