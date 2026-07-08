# Changelog

이 프로젝트의 주요 변경 사항을 기록합니다.

## [Unreleased]

## [0.9.4] - 2026-07-08

### 변경

- Notice 활성 기간의 현재 시간 판정을 `NoticeChecker`로 단일화해 `RemoteConfigNoticeParser`가 Remote Config 값 파싱과 모델 생성만 담당하도록 정리했습니다.
- `NoticeChecker`의 현재 시각 판정을 `Dependencies`의 date 의존성으로 통합해 Notice 활성 기간 테스트가 시스템 현재 시각에 직접 의존하지 않도록 개선했습니다.

## [0.9.3] - 2026-07-08

### 변경

- 현재 구현에서 throw되지 않는 `LaunchingServiceError` legacy case에 deprecation 안내를 추가했습니다.

### 문서

- `RemoteConfigRegisterdKeys`의 필수 Firebase Remote Config 값과 기능별 활성 조건을 README에 정리했습니다.
- `fetchAndActivate()` 실패 시 기존 활성값 또는 기본값으로 파싱을 계속하는 fallback 동작을 문서화했습니다.
- Force update, Blacklist force update, Optional update, Notice의 상태 판정 우선순위와 URL/날짜 파싱 실패 동작을 명확히 했습니다.
- Remote Config 경계 케이스별 결과 표를 추가해 값 누락, 파싱 실패, 기간 불일치 시 다음 상태 판정 흐름을 빠르게 확인할 수 있게 했습니다.
- `LaunchingServiceError` 문서를 현재 구현 기준으로 정리해 Remote Config 값 문제는 throw가 아니라 기능 비활성으로 처리된다는 점을 명확히 했습니다.
- DocC 첫 화면에 기본 사용법, Remote Config 계약, 상태 판정 흐름, 주요 API 탐색 섹션을 보강했습니다.
- 커스텀 Remote Config key 예제를 복사 가능한 Swift 코드 형태로 정리하고, 버전 비교 방식과 availability 조건을 문서화했습니다.

## [0.9.2] - 2026-05-17

### 변경

- `swift-dependencies` 지원 범위를 `1.4.0` 이상으로 업데이트했습니다.

## [0.9.1] - 2026-05-17

### 변경

- 공지 날짜 파싱을 `Date.ISO8601FormatStyle()` 기반으로 개선했습니다.
- 테스트를 XCTest에서 Swift Testing 기반으로 전환했습니다.

## [0.9.0] - 2026-05-16

### 추가

- DocC 문서를 `swift-man/docs` 저장소로 배포하는 GitHub Actions 흐름을 추가했습니다.

### 변경

- Remote Config 업데이트 판정 안정성을 개선했습니다.
- 코드리뷰 후속 개선 사항을 반영했습니다.
- README의 문서 사이트 링크를 최신 DocC 배포 경로로 정리했습니다.

## [0.8.1] - 2023-02-18

### 변경

- DocC 주석 연결과 문서 호스팅 설정을 정리했습니다.

[Unreleased]: https://github.com/swift-man/LaunchingService/compare/0.9.4...HEAD
[0.9.4]: https://github.com/swift-man/LaunchingService/releases/tag/0.9.4
[0.9.3]: https://github.com/swift-man/LaunchingService/releases/tag/0.9.3
[0.9.2]: https://github.com/swift-man/LaunchingService/releases/tag/0.9.2
[0.9.1]: https://github.com/swift-man/LaunchingService/releases/tag/0.9.1
[0.9.0]: https://github.com/swift-man/LaunchingService/releases/tag/0.9.0
[0.8.1]: https://github.com/swift-man/LaunchingService/releases/tag/0.8.1
