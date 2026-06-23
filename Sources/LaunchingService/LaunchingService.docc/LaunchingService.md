# ``LaunchingService``

Firebase Remote Config 기반 앱 실행 상태 확인 서비스입니다.

## Overview

`LaunchingService`는 앱 시작 시 Firebase Remote Config 값을 읽고, 현재 앱 버전과 설정 값을 비교해 앱이 어떤 실행 상태로 진입해야 하는지 계산합니다. 서비스는 UI를 직접 표시하지 않고 ``AppUpdateStatus``만 반환합니다. 강제 업데이트 화면, 선택 업데이트 화면, 공지 얼럿 같은 실제 presentation 처리는 앱 또는 별도 UI 패키지에서 담당합니다.

가장 기본적인 사용법은 앱 시작 흐름에서 ``LaunchingService/fetchAppUpdateStatus()``를 호출하고, 반환된 상태에 맞춰 화면을 분기하는 것입니다.

```swift
let service = LaunchingService()
let status = try await service.fetchAppUpdateStatus()
```

### Runtime Flow

`fetchAppUpdateStatus()`는 Firebase Remote Config의 `fetchAndActivate()`를 먼저 시도합니다. fetch가 실패해도 즉시 오류로 종료하지 않고, 현재 활성값 또는 기본값을 기준으로 상태 파싱을 계속 진행합니다. 이후 앱 버전과 Remote Config 값을 비교해 아래 우선순서로 상태를 판단합니다.

1. Force update
2. Blacklist force update
3. Optional update
4. Notice
5. ``AppUpdateStatus/valid``

앞선 상태가 활성화되면 뒤의 상태는 평가 결과로 노출되지 않습니다. 예를 들어 강제 업데이트가 필요한 경우 공지 조건이 맞더라도 반환 상태는 ``AppUpdateStatus/forcedUpdateRequired(_:)``입니다.

### Remote Config Contract

``RemoteConfigRegisterdKeys``는 Firebase Remote Config에서 읽을 키 이름을 정의합니다. 기본 키를 그대로 사용한다면 Remote Config에 다음 값들이 기능별 활성 조건으로 등록되어야 합니다.

| Feature | Required values | Activation condition |
| --- | --- | --- |
| Force update | `forceUpdateAlertDoneLinkURLKey`, `forceUpdateAppVersionKey` | 강제 업데이트 버전이 현재 앱 버전보다 높음 |
| Blacklist force update | `forceUpdateAlertDoneLinkURLKey`, `blackListVersionsKey` | 블랙리스트 버전 목록이 현재 앱 버전을 포함함 |
| Optional update | `optionalUpdateAppVersionKey`, `optionalUpdateAlertDoneLinkURLKey` | 선택 업데이트 버전이 현재 앱 버전보다 높음 |
| Notice | `noticeStartDateKey`, `noticeEndDateKey` | 현재 시간이 공지 기간 안에 있음 |

업데이트 계열에서 URL 값이 없거나 URL로 파싱되지 않으면 해당 업데이트 상태는 비활성으로 판단됩니다. Notice의 시작일 또는 종료일이 ISO8601 날짜로 파싱되지 않거나, 시작일이 종료일보다 같거나 늦으면 Notice도 비활성입니다.

Notice의 `noticeAlertDoneURLKey`는 공지 노출 조건이 아닙니다. 값이 없거나 URL로 파싱되지 않아도 공지는 노출될 수 있고, ``NoticeAlert/doneURL``만 `nil`로 전달됩니다. 버튼 숨김, 비활성화, 링크 없는 확인 동작은 presentation layer에서 결정합니다.

타이틀과 메시지 값은 파서 기준으로 생략될 수 있지만, 값이 없으면 빈 문자열로 노출될 수 있습니다. 사용자에게 보이는 문구이므로 실제 서비스에서는 함께 설정하는 것을 권장합니다.

## Topics

### Service

- ``LaunchingService``
- ``LaunchingInteractable``

### Status

- ``AppUpdateStatus``
- ``UpdateAlert``
- ``NoticeAlert``

### Configuration

- ``RemoteConfigRegisterdKeys``

### Parsed Values

- ``Launching``
- ``AppUpdateInfo``
- ``NoticeInfo``

### Errors

- ``LaunchingServiceError``
