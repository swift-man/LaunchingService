//
//  RemoteConfigRegisterdKeys.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation
import Dependencies

/// Firebase RemoteConfig 의 alignment 를 설정 합니다.
public struct RemoteConfigRegisterdKeys: Sendable {
  public struct ForceUpdateKeys: Sendable {
    let appVersionKey: String
    let alertTitleKey: String
    let alertMessageKey: String
    let alertDoneLinkURLKey: String
    let blackListVersionsKey: String
    
    /// Firebase RemoteConfig 의 `강제 업데이트`키 값을 커스텀으로 설정 합니다.
    /// - Parameters:
    ///   - appVersionKey: `강제 업데이트 버전`의 키를 설정 합니다. 기본 값 : `forceUpdateAppVersionKey`
    ///   - alertTitleKey: 강제 업데이트 버전의 `타이틀` 키를 설정 합니다. 기본 값 : `forceUpdateAlertTitleKey`
    ///   - alertMessageKey: 강제 업데이트 버전의 `메시지` 키를 설정 합니다. 기본 값 : `forceUpdateAlertMessageKey`
    ///   - alertDoneLinkURLKey: `강제 업데이트 URL` 키를 설정 합니다. 기본 값 : `forceUpdateAlertDoneLinkURLKey`
    ///   - blackListVersionsKey: 블랙리스트 버전들의 키를 설정 합니다. 기본 값 : `blackListVersionsKey`
    public init(appVersionKey: String = "forceUpdateAppVersionKey",
                alertTitleKey: String = "forceUpdateAlertTitleKey",
                alertMessageKey: String = "forceUpdateAlertMessageKey",
                alertDoneLinkURLKey: String = "forceUpdateAlertDoneLinkURLKey",
                blackListVersionsKey: String = "blackListVersionsKey") {
      self.appVersionKey = appVersionKey
      self.alertTitleKey = alertTitleKey
      self.alertMessageKey = alertMessageKey
      self.alertDoneLinkURLKey = alertDoneLinkURLKey
      self.blackListVersionsKey = blackListVersionsKey
    }
  }
  
  public struct OptionalUpdateKeys: Sendable {
    let appVersionKey: String
    let alertTitleKey: String
    let alertMessageKey: String
    let alertDoneLinkURLKey: String
    
    /// Firebase RemoteConfig 의 `선택 업데이트` 키 값을 커스텀으로 설정 합니다.
    /// - Parameters:
    ///   - appVersionKey: `선택  업데이트 버전`의 키를 설정 합니다. 기본 값 : `optionalUpdateAppVersionKey`
    ///   - alertTitleKey: 선택 업데이트 버전의 `타이틀` 키를 설정 합니다. 기본 값 : `optionalUpdateAlertTitleKey`
    ///   - alertMessageKey: 선택 업데이트 버전의 `메시지` 키를 설정 합니다. 기본 값 : `optionalUpdateMessageKey`
    ///   - alertDoneLinkURLKey: `선택 업데이트 URL` 키를 설정 합니다. 기본 값 : `optionalUpdateAlertDoneLinkURLKey`
    public init(appVersionKey: String = "optionalUpdateAppVersionKey",
                alertTitleKey: String = "optionalUpdateAlertTitleKey",
                alertMessageKey: String = "optionalUpdateMessageKey",
                alertDoneLinkURLKey: String = "optionalUpdateAlertDoneLinkURLKey") {
      self.appVersionKey = appVersionKey
      self.alertTitleKey = alertTitleKey
      self.alertMessageKey = alertMessageKey
      self.alertDoneLinkURLKey = alertDoneLinkURLKey
    }
  }
  
  public struct NoticeKeys: Sendable {
    let alertTitleKey: String
    let alertMessageKey: String
    let startDateKey: String
    let endDateKey: String
    let alertDoneURLKey: String
    let alertDismissedTerminateKey: String
    
    /// Firebase RemoteConfig 의 `공지사항` 키 값을 커스텀으로 설정 합니다.
    /// - Parameters:
    ///   - alertTitleKey: 공지 타이틀 키를 설정 합니다. 기본 값 : `noticeAlertTitleKey`
    ///   - alertMessageKey: 공지 메시지 키를 설정 합니다. 기본 값 : `noticeAlertMessageKey`
    ///   - startDateKey: 공지 시작일 키를 설정 합니다. 기본 값 : `noticeStartDateKey`
    ///   - endDateKey: 공지 종료일 키를 설정 합니다. 기본 값 : `noticeEndDateKey`
    ///   - alertDoneURLKey: 공지 확인 URL 키를 설정 합니다. 기본 값 : `noticeAlertDoneURLKey`
    ///   - alertDismissedTerminateKey: 공지 종료 키를 설정 합니다. 기본 값 : `noticeAlertDismissedTerminateKey`
    public init(alertTitleKey: String = "noticeAlertTitleKey",
                alertMessageKey: String = "noticeAlertMessageKey",
                startDateKey: String = "noticeStartDateKey",
                endDateKey: String = "noticeEndDateKey",
                alertDoneURLKey: String = "noticeAlertDoneURLKey",
                alertDismissedTerminateKey: String = "noticeAlertDismissedTerminateKey") {
      self.alertTitleKey = alertTitleKey
      self.alertMessageKey = alertMessageKey
      self.startDateKey = startDateKey
      self.endDateKey = endDateKey
      self.alertDoneURLKey = alertDoneURLKey
      self.alertDismissedTerminateKey = alertDismissedTerminateKey
    }
  }
  
  let forceUpdateKeys: ForceUpdateKeys
  let optionalUpdateKeys: OptionalUpdateKeys
  let noticeKeys: NoticeKeys
  
  
  /// Firebase RemoteConfig 의 키 값을 커스텀으로 설정 합니다.
  /// - Parameters:
  ///   - forceUpdateKey: 강제 업데이트 키
  ///   - optionalUpdateKeys: 선택 업데이트 키
  ///   - noticeKeys: 공지 사항 키
  public init(forceUpdateKeys: ForceUpdateKeys = ForceUpdateKeys(),
              optionalUpdateKeys: OptionalUpdateKeys = OptionalUpdateKeys(),
              noticeKeys: NoticeKeys = NoticeKeys()) {
    self.forceUpdateKeys = forceUpdateKeys
    self.optionalUpdateKeys = optionalUpdateKeys
    self.noticeKeys = noticeKeys
  }
}

extension RemoteConfigRegisterdKeys: TestDependencyKey {
  public static var testValue: RemoteConfigRegisterdKeys {
    RemoteConfigRegisterdKeys()
  }
}

extension DependencyValues {
  public var remoteConfigRegisterdKeys: RemoteConfigRegisterdKeys {
    get { self[RemoteConfigRegisterdKeys.self] }
    set { self[RemoteConfigRegisterdKeys.self] = newValue }
  }
}
