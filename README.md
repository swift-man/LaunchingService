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
`fetchAppUpdateStatus()`는 앱 버전 조회에 실패한 경우 오류를 throw할 수 있습니다. 기본 구현에서는 `Bundle.main`의 `CFBundleShortVersionString`이 없거나 비어 있을 때 `invalidMainBundleReleaseVersionNumber`가 발생합니다.

Firebase Remote Config의 fetch 실패는 현재 활성값 또는 기본값으로 fallback하며, Remote Config 값 누락, URL 파싱 실패, 날짜 파싱 실패는 오류가 아니라 해당 기능 비활성으로 처리됩니다. 아래 enum의 Remote Config 관련 case와 `unknown`은 public API 호환성을 위해 유지되지만, 현재 Remote Config 파서 흐름에서는 throw되지 않으므로 deprecated 처리되어 있습니다.

```swift
@available(iOS 15.0, macOS 12, tvOS 15, watchOS 8.0, *)
public enum LaunchingServiceError: Error, Equatable, Sendable {
  @available(*, deprecated, message: "Remote Config URL parsing failures are treated as inactive feature states.")
  case invalidLinkURLValue

  @available(*, deprecated, message: "Missing Remote Config link URL keys are treated as inactive feature states.")
  case notFoundLinkURLKey

  @available(*, deprecated, message: "Missing force update version keys are treated as inactive feature states.")
  case notFoundForceUpdateAppVersionKey

  @available(*, deprecated, message: "Missing optional update version keys are treated as inactive feature states.")
  case notFoundOptionalUpdateAppVersionKey

  case invalidMainBundleReleaseVersionNumber

  @available(*, deprecated, message: "The current LaunchingService implementation does not throw unknown errors.")
  case unknown
}
```

## Firebase Remote Config Values
`RemoteConfigRegisterdKeys`는 Firebase Remote Config에서 읽을 키 이름을 정의합니다. 기본 initializer를 사용한다면 Firebase Remote Config에 아래 기본 키 이름으로 값을 등록해야 합니다.

`fetchAppUpdateStatus()`는 Firebase Remote Config의 `fetchAndActivate()`가 실패해도 현재 활성값 또는 기본값을 기준으로 앱 상태 파싱을 계속 진행합니다.

값이 없거나 공백인 경우의 동작은 키의 역할에 따라 다릅니다.

- Force update는 `forceUpdateAlertDoneLinkURLKey`와 `forceUpdateAppVersionKey`가 활성 조건입니다.
- Blacklist force update는 `forceUpdateAlertDoneLinkURLKey`와 `blackListVersionsKey`가 활성 조건입니다.
- Optional update는 `optionalUpdateAppVersionKey`와 `optionalUpdateAlertDoneLinkURLKey`가 활성 조건입니다.
- Notice는 `noticeStartDateKey`와 `noticeEndDateKey`가 활성 조건입니다.
- Force update와 Blacklist force update의 `forceUpdateAlertDoneLinkURLKey`, Optional update의 `optionalUpdateAlertDoneLinkURLKey`가 URL로 파싱되지 않으면 해당 기능은 비활성 상태로 판단됩니다.
- Notice의 시작일 또는 종료일이 ISO8601 날짜로 파싱되지 않거나, 시작일이 종료일보다 같거나 늦으면 Notice는 비활성 상태로 판단됩니다.
- Notice의 `noticeAlertDoneURLKey`는 예외적으로 활성 조건이 아니며, 파싱되지 않아도 Notice는 계속 노출될 수 있고 `doneURL`만 제공되지 않습니다.
- 타이틀과 메시지 문자열이 없으면 기능 트리거는 유지될 수 있고, 빈 문자열로 노출될 수 있습니다.
- `noticeAlertDismissedTerminateKey` 같은 Bool 설정이 없으면 `false`로 처리됩니다.

상태 판정 우선순위는 Force update, Blacklist force update, Optional update, Notice, `AppUpdateStatus.valid` 순서입니다. 특정 기능의 활성 조건이 만족되지 않으면 다음 조건으로 넘어가며, 모든 기능이 비활성 상태일 때 `valid`가 반환됩니다.

Force update와 Optional update의 버전 비교는 단순 문자열 비교가 아니라 `String.compare(_:options: .numeric)` 기반입니다. 버전 component 수가 다르면 부족한 쪽에 `0`을 채운 뒤 비교합니다. 예를 들어 `1.10`과 `1.2.0`을 비교할 때 `1.10`은 `1.10.0`처럼 보정되고, 숫자 비교 기준으로 `1.10.0`은 `1.2.0`보다 높은 버전으로 판단됩니다.

타이틀과 메시지는 파서 기준으로는 생략할 수 있지만, 사용자에게 보여지는 얼럿 문구이므로 실제 서비스에서는 함께 설정하는 것을 권장합니다.

### Required Values by Feature
| Feature | Required values | Activation condition | Recommended / optional values |
| --- | --- | --- | --- |
| Force update | `forceUpdateAlertDoneLinkURLKey`: 유효한 URL<br>`forceUpdateAppVersionKey`: 강제 업데이트 버전 | `forceUpdateAppVersionKey`가 현재 앱 버전보다 높음 | `forceUpdateAlertTitleKey`<br>`forceUpdateAlertMessageKey` |
| Blacklist force update | `forceUpdateAlertDoneLinkURLKey`: 유효한 URL<br>`blackListVersionsKey`: comma-separated 버전 목록 | `blackListVersionsKey`가 현재 앱 버전을 포함함 | `forceUpdateAlertTitleKey`<br>`forceUpdateAlertMessageKey` |
| Optional update | `optionalUpdateAppVersionKey`: 선택 업데이트 버전<br>`optionalUpdateAlertDoneLinkURLKey`: 유효한 URL | `optionalUpdateAppVersionKey`가 현재 앱 버전보다 높음 | `optionalUpdateAlertTitleKey`<br>`optionalUpdateAlertMessageKey` |
| Notice | `noticeStartDateKey`: ISO8601 시작일<br>`noticeEndDateKey`: ISO8601 종료일 | 시작일이 종료일보다 빠르고, 현재 시간이 기간 안에 있음 | `noticeAlertTitleKey`<br>`noticeAlertMessageKey`<br>`noticeAlertDoneURLKey`<br>`noticeAlertDismissedTerminateKey` |

`forceUpdateAlertDoneLinkURLKey`는 강제 업데이트 버전 체크와 블랙리스트 체크에 공통으로 필요합니다. 이 URL 값이 없거나 유효하지 않으면 `forceUpdateAppVersionKey`, `blackListVersionsKey` 값이 있어도 강제 업데이트와 블랙리스트 체크가 비활성화됩니다.

`optionalUpdateAlertDoneLinkURLKey`는 선택 업데이트에 필요합니다. 이 URL 값이 없거나 유효하지 않으면 `optionalUpdateAppVersionKey` 값이 있어도 선택 업데이트 체크가 비활성화됩니다.

`LaunchingService`는 `noticeAlertDoneURLKey`가 없거나 파싱되지 않은 경우 UI 버튼 표시 여부를 결정하지 않고 `NoticeAlert.doneURL`에 `nil`을 전달합니다. 버튼 숨김, 비활성화, 링크 없는 확인 동작은 presentation layer에서 결정합니다.

### Remote Config Edge Cases
| Case | Result |
| --- | --- |
| `fetchAndActivate()` 실패 | fetch 실패만으로는 종료하지 않고 현재 활성값 또는 기본값으로 상태 파싱을 계속합니다. 앱 버전 조회 실패는 여전히 throw될 수 있습니다. |
| `forceUpdateAppVersionKey`가 없거나 공백 | Force update 버전 비교를 건너뛰고 Blacklist force update를 평가합니다. |
| `forceUpdateAlertDoneLinkURLKey`가 없거나 URL로 파싱되지 않음 | Force update와 Blacklist force update를 모두 비활성으로 판단하고 Optional update를 평가합니다. |
| `blackListVersionsKey`가 없거나 공백 | Blacklist force update를 건너뛰고 Optional update를 평가합니다. |
| `blackListVersionsKey`가 현재 앱 버전을 포함하지 않음 | Blacklist force update를 건너뛰고 Optional update를 평가합니다. |
| `optionalUpdateAppVersionKey`가 없거나 공백 | Optional update를 비활성으로 판단하고 Notice를 평가합니다. |
| `optionalUpdateAlertDoneLinkURLKey`가 없거나 URL로 파싱되지 않음 | Optional update를 비활성으로 판단하고 Notice를 평가합니다. |
| `noticeStartDateKey` 또는 `noticeEndDateKey`가 없거나 ISO8601 날짜로 파싱되지 않음 | Notice를 비활성으로 판단합니다. 앞선 상태도 모두 비활성이면 `AppUpdateStatus.valid`를 반환합니다. |
| Notice 시작일이 종료일보다 같거나 늦음 | Notice를 비활성으로 판단합니다. 앞선 상태도 모두 비활성이면 `AppUpdateStatus.valid`를 반환합니다. |
| 현재 시간이 Notice 기간 밖에 있음 | Notice를 비활성으로 판단합니다. 앞선 상태도 모두 비활성이면 `AppUpdateStatus.valid`를 반환합니다. |
| `noticeAlertDoneURLKey`가 없거나 URL로 파싱되지 않음 | Notice 활성 조건에는 영향을 주지 않고 `NoticeAlert.doneURL`만 `nil`로 전달합니다. |
| 타이틀 또는 메시지가 없거나 공백 | 상태 활성 조건에는 영향을 주지 않습니다. Remote Config에서 읽은 문자열이 그대로 전달될 수 있으므로 실제 서비스에서는 함께 설정하는 것을 권장합니다. |
| `noticeAlertDismissedTerminateKey`가 없음 | `false`로 처리됩니다. |
| 모든 기능이 비활성 | `AppUpdateStatus.valid`를 반환합니다. |

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
| Notice | `noticeAlertDismissedTerminateKey` | Bool, default `false` |

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

기본 키 이름을 그대로 사용한다면 별도 값 없이 기본 initializer를 사용할 수 있습니다.

```swift
import Dependencies

@available(iOS 15.0, macOS 12, tvOS 15, watchOS 8.0, *)
extension RemoteConfigRegisterdKeys: DependencyKey {
  public static var liveValue = RemoteConfigRegisterdKeys()
}
```

Remote Config 키 이름을 앱별로 바꾸려면 각 key group에 실제 문자열 키를 전달합니다.

```swift
import Dependencies

@available(iOS 15.0, macOS 12, tvOS 15, watchOS 8.0, *)
extension RemoteConfigRegisterdKeys: DependencyKey {
  public static var liveValue = RemoteConfigRegisterdKeys(
    forceUpdateKeys: .init(
      appVersionKey: "launching_force_update_version",
      alertTitleKey: "launching_force_update_title",
      alertMessageKey: "launching_force_update_message",
      alertDoneLinkURLKey: "launching_force_update_done_url",
      blackListVersionsKey: "launching_blacklist_versions"
    ),
    optionalUpdateKeys: .init(
      appVersionKey: "launching_optional_update_version",
      alertTitleKey: "launching_optional_update_title",
      alertMessageKey: "launching_optional_update_message",
      alertDoneLinkURLKey: "launching_optional_update_done_url"
    ),
    noticeKeys: .init(
      alertTitleKey: "launching_notice_title",
      alertMessageKey: "launching_notice_message",
      startDateKey: "launching_notice_start_date",
      endDateKey: "launching_notice_end_date",
      alertDoneURLKey: "launching_notice_done_url",
      alertDismissedTerminateKey: "launching_notice_dismissed_terminate"
    )
  )
}
```

## 블랙리스트 업데이트
현재 앱 버전이 블랙리스트 버전에 포함되면 강제 업데이트 상태로 판단됩니다. `blackListVersionsKey`는 comma-separated 버전 문자열이며, `forceUpdateAlertDoneLinkURLKey`도 유효한 URL 값으로 설정되어 있어야 합니다.

```
1.0.0, 1.2.0, 2.0.0
```

## 공지사항
### 날짜 형식
공지 날짜는 `Date.ISO8601FormatStyle()`로 파싱됩니다. 두 날짜가 모두 유효하고, `noticeStartDateKey`가 `noticeEndDateKey`보다 빠르며, 현재 시간이 기간 안에 있을 때만 공지가 노출됩니다.
운영 일관성을 위해 UTC `Z` 문자열을 권장합니다. `Date.ISO8601FormatStyle()`로 파싱 가능한 timezone offset이 포함된 ISO8601 문자열도 사용할 수 있습니다.

```
2026-06-24T00:00:00Z
```

* noticeStartDateKey
  * value: String (ex: 2026-06-24T00:00:00Z) // UTC
  
* noticeEndDateKey
  * value: String (ex: 2026-06-25T00:00:00Z) // UTC
 
### 제목, 메시지
* noticeAlertTitleKey
  * value: String
* noticeAlertMessageKey
  * value: String

### 공지 링크
* noticeAlertDoneURLKey
  * value: String (ex: https://google.com)

### 앱 종료
* noticeAlertDismissedTerminateKey
  * value: Bool

## 설치
### Swift Package Manager

[Swift Package Manager](https://swift.org/package-manager/)는 Swift 코드 배포를 자동화하는 도구이며 `swift` 컴파일러에 통합되어 있습니다.

Swift package 설정이 끝났다면 `Package.swift`의 `dependencies` 값에 LaunchingService를 추가해 사용할 수 있습니다.

```swift
dependencies: [
    .package(url: "https://github.com/swift-man/LaunchingService.git", from: "0.9.2")
]
```
