//
//  LaunchingServiceKeyStore.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation

/// Firebase RemoteConfig 의 alignment 를 설정 합니다.
public struct LaunchingServiceKeyStore: Sendable {
  let appStoreURLKey: String
  
  let blackListVersionsKey: String
  
  let forceUpdateAppVersionKey: String
  let forceUpdateMessageKey: String
  
  let optionalUpdateAppVersionKey: String
  let optionalUpdateMessageKey: String
  
  let noticeAlertTitleKey: String
  let noticeAlertMessageKey: String
  let noticeStartDateKey: String
  let noticeEndDateKey: String
  let noticeAlertDoneURLKey: String
  let noticeAlertDismissedTerminateKey: String
  
  /// Firebase RemoteConfig 의 키 값을 커스텀으로 설정 합니다.
  /// - Parameters:
  ///   - appStoreURLKey: `스토어 URL` 키를 설정 합니다. 기본 값 : `appStoreURLKey`
  ///   - forceUpdateAppVersionKey: `강제 업데이트 버전`의 키를 설정 합니다. 기본 값 : `forceUpdateAppVersionKey`
  ///   - forceUpdateMessageKey: 강제 업데이트 버전의 `메시지` 키를 설정 합니다. 기본 값 : `forceUpdateMessageKey`
  ///   - optionalUpdateAppVersionKey: `선택 업데이트 버전`의 키를 설정 합니다. 기본 값 : `optionalUpdateAppVersionKey`
  ///   - optionalUpdateMessageKey: 선택 업데이트 버전의 `메시지` 키를 설정 합니다. 기본 값 : `optionalUpdateMessageKey`
  ///   - blackListVersionsKey: 블랙리스트 버전들의 키를 설정 합니다. 기본 값 : `blackListVersionsKey`
  ///   - noticeAlertTitleKey: 공지 타이틀 키를 설정 합니다. 기본 값 : `noticeAlertTitleKey`
  ///   - noticeAlertMessageKey: 공지 메시지 키를 설정 합니다. 기본 값 : `noticeAlertMessageKey`
  ///   - noticeStartDateKey: 공지 시작일 키를 설정 합니다. 기본 값 : `noticeStartDateKey`
  ///   - noticeEndDateKey: 공지 종료일 키를 설정 합니다. 기본 값 : `noticeEndDateKey`
  ///   - noticeAlertDoneURLKey: 공지 확인 URL 키를 설정 합니다. 기본 값 : `noticeAlertDoneURLKey`
  ///   - noticeAlertDismissedTerminateKey: 공지 종료 키를 설정 합니다. 기본 값 : `noticeAlertDismissedTerminateKey`
  public init(appStoreURLKey: String = "appStoreURLKey",
              forceUpdateAppVersionKey: String = "forceUpdateAppVersionKey",
              forceUpdateMessageKey: String = "forceUpdateMessageKey",
              optionalUpdateAppVersionKey: String = "optionalUpdateAppVersionKey",
              optionalUpdateMessageKey: String = "optionalUpdateMessageKey",
              blackListVersionsKey: String = "blackListVersionsKey",
              noticeAlertTitleKey: String = "noticeAlertTitleKey",
              noticeAlertMessageKey: String = "noticeAlertMessageKey",
              noticeStartDateKey: String = "noticeStartDateKey",
              noticeEndDateKey: String = "noticeEndDateKey",
              noticeAlertDoneURLKey: String = "noticeAlertDoneURLKey",
              noticeAlertDismissedTerminateKey: String = "noticeAlertDismissedTerminateKey") {
    self.appStoreURLKey = appStoreURLKey
    
    self.forceUpdateAppVersionKey = forceUpdateAppVersionKey
    self.forceUpdateMessageKey = forceUpdateMessageKey
    
    self.optionalUpdateAppVersionKey = optionalUpdateAppVersionKey
    self.optionalUpdateMessageKey = optionalUpdateMessageKey
    
    self.blackListVersionsKey = blackListVersionsKey
    
    self.noticeAlertTitleKey = noticeAlertTitleKey
    self.noticeAlertMessageKey = noticeAlertMessageKey
    self.noticeStartDateKey = noticeStartDateKey
    self.noticeEndDateKey = noticeEndDateKey
    self.noticeAlertDoneURLKey = noticeAlertDoneURLKey
    self.noticeAlertDismissedTerminateKey = noticeAlertDismissedTerminateKey
  }
}
