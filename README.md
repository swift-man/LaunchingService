# LaunchingService

![Badge](https://img.shields.io/badge/swift-white.svg?style=flat-square&logo=Swift)
![Badge](https://img.shields.io/badge/SwiftUI-001b87.svg?style=flat-square&logo=Swift&logoColor=black)
![Badge - Version](https://img.shields.io/badge/Version-0.9.2-1177AA?style=flat-square)
![Badge - Swift Package Manager](https://img.shields.io/badge/SPM-compatible-orange?style=flat-square)
![Badge - Platform](https://img.shields.io/badge/platform-mac_12|ios_15|tvos_15|watchos_8-yellow?style=flat-square)
![Badge - License](https://img.shields.io/badge/license-MIT-black?style=flat-square)  

---
## 강제 업데이트 / 선택 업데이트 / 공지사항을 유저에게 제공합니다.
### Documentation Website
[LaunchingService](https://docs.gorani.me/LaunchingService/documentation/launchingservice/)

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
let appUpdateState = try await service.fetchAppUpdateStatus()
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
  case invalidLinkURLValue
  case notFoundLinkURLKey
  case notFoundForceUpdateAppVersionKey
  case notFoundOptionalUpdateAppVersionKey
  case invalidMainBundleReleaseVersionNumber
  case unknown
}
```

## Firebase Remote Config Values
`RemoteConfigRegisterdKeys`는 Firebase Remote Config에서 읽을 키 이름을 정의합니다. 기본 initializer를 사용한다면 Firebase Remote Config에 아래 기본 키 이름으로 값을 등록해야 합니다.

문자열 값이 없거나 공백이면 비활성 값으로 처리되고, Bool 값이 없으면 `false`로 처리됩니다. 타이틀과 메시지는 파서 기준으로는 생략할 수 있지만, 사용자에게 보여지는 얼럿 문구이므로 실제 서비스에서는 함께 설정하는 것을 권장합니다.

### Required Values by Feature
| Feature | Required values | Recommended / optional values |
| --- | --- | --- |
| Force update | `forceUpdateAlertDoneLinkURLKey`: 유효한 URL<br>`forceUpdateAppVersionKey`: 현재 앱 버전보다 높은 강제 업데이트 버전 | `forceUpdateAlertTitleKey`<br>`forceUpdateAlertMessageKey` |
| Blacklist force update | `forceUpdateAlertDoneLinkURLKey`: 유효한 URL<br>`blackListVersionsKey`: 현재 앱 버전을 포함한 comma-separated 버전 목록 | `forceUpdateAlertTitleKey`<br>`forceUpdateAlertMessageKey` |
| Optional update | `optionalUpdateAppVersionKey`: 현재 앱 버전보다 높은 선택 업데이트 버전<br>`optionalUpdateAlertDoneLinkURLKey`: 유효한 URL | `optionalUpdateAlertTitleKey`<br>`optionalUpdateAlertMessageKey` |
| Notice | `noticeStartDateKey`: ISO8601 시작일<br>`noticeEndDateKey`: ISO8601 종료일<br>시작일이 종료일보다 빠르고, 현재 시간이 기간 안에 있어야 함 | `noticeAlertTitleKey`<br>`noticeAlertMessageKey`<br>`noticeAlertDoneURLKey`<br>`noticeAlertDismissedTerminateKey` |

`forceUpdateAlertDoneLinkURLKey`는 강제 업데이트 버전 체크와 블랙리스트 체크에 공통으로 필요합니다. 이 URL 값이 없거나 유효하지 않으면 `forceUpdateAppVersionKey`, `blackListVersionsKey` 값이 있어도 강제 업데이트와 블랙리스트 체크가 비활성화됩니다.

`noticeAlertDoneURLKey`는 공지 노출 조건이 아닙니다. 이 값이 없거나 URL로 파싱되지 않으면 공지는 계속 노출될 수 있고, `doneURL`만 제공되지 않습니다.

### Default Key Names
| Group | Key | Value type |
| --- | --- | --- |
| Force update | `forceUpdateAppVersionKey` | String, e.g. `2.0.0` |
| Force update | `forceUpdateAlertTitleKey` | String |
| Force update | `forceUpdateAlertMessageKey` | String |
| Force update | `forceUpdateAlertDoneLinkURLKey` | String URL |
| Force update | `blackListVersionsKey` | String, e.g. `1.0.0, 1.2.0, 2.0.0` |
| Optional update | `optionalUpdateAppVersionKey` | String, e.g. `1.5.0` |
| Optional update | `optionalUpdateAlertTitleKey` | String |
| Optional update | `optionalUpdateAlertMessageKey` | String |
| Optional update | `optionalUpdateAlertDoneLinkURLKey` | String URL |
| Notice | `noticeAlertTitleKey` | String |
| Notice | `noticeAlertMessageKey` | String |
| Notice | `noticeStartDateKey` | String ISO8601 date |
| Notice | `noticeEndDateKey` | String ISO8601 date |
| Notice | `noticeAlertDoneURLKey` | String URL |
| Notice | `noticeAlertDismissedTerminateKey` | Bool |

### Minimal Remote Config Examples
Force update:

```text
forceUpdateAppVersionKey = 2.0.0
forceUpdateAlertDoneLinkURLKey = https://apps.apple.com/app/id0000000000
forceUpdateAlertTitleKey = 업데이트가 필요합니다
forceUpdateAlertMessageKey = 안정적인 사용을 위해 최신 버전으로 업데이트해주세요.
```

Blacklist force update:

```text
blackListVersionsKey = 1.0.0, 1.0.1
forceUpdateAlertDoneLinkURLKey = https://apps.apple.com/app/id0000000000
forceUpdateAlertTitleKey = 업데이트가 필요합니다
forceUpdateAlertMessageKey = 현재 버전은 더 이상 지원하지 않습니다.
```

Optional update:

```text
optionalUpdateAppVersionKey = 1.5.0
optionalUpdateAlertDoneLinkURLKey = https://apps.apple.com/app/id0000000000
optionalUpdateAlertTitleKey = 새 버전이 있습니다
optionalUpdateAlertMessageKey = 더 나은 사용성을 위해 업데이트할 수 있습니다.
```

Notice:

```text
noticeStartDateKey = 2026-06-24T00:00:00Z
noticeEndDateKey = 2026-06-25T00:00:00Z
noticeAlertTitleKey = 점검 안내
noticeAlertMessageKey = 서비스 점검이 예정되어 있습니다.
noticeAlertDoneURLKey = https://example.com/notice
noticeAlertDismissedTerminateKey = false
```

### Your Custom Remote Config Keys
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
If the app is a blacklisted version, it is force updated. `blackListVersionsKey` is a comma-separated string, and `forceUpdateAlertDoneLinkURLKey` must also be set to a URL value.

```
1.0.0, 1.2.0, 2.0.0
```

## Notice
### DateFormat
Notice dates are parsed with `Date.ISO8601FormatStyle()`. The notice is shown only when both dates are valid, `noticeStartDateKey` is earlier than `noticeEndDateKey`, and the current time is inside that range.

```
2026-06-24T00:00:00Z
```

* noticeStartDateKey
  * value: String (ex: 2026-06-24T00:00:00Z) // UTC
  
* noticeEndDateKey
  * value: String (ex: 2026-06-25T00:00:00Z) // UTC
 
### Title, Message
* noticeAlertTitleKey
  * value: String
* noticeAlertMessageKey
  * value: String

### URL Landing
* noticeAlertDoneURLKey
  * value: String (ex: https://google.com)

### App Terminate
* noticeAlertDismissedTerminateKey
  * value: Bool

## Installation
### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding LaunchingService as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/swift-man/LaunchingService.git", from: "0.9.2")
]
```
