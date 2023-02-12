//
//  LaunchingService.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Firebase
import FirebaseRemoteConfig
import Dependencies

/// 앱을 구성하기 전 외부로 부터 설정을 가져와 앱 상태를 반환하는 서비스 입니다.
public final class LaunchingService: LaunchingInteractable, Sendable {
  /// Creates an instance with the given alignment.
  public init() {
  }
  
  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  /// - Parameter keyStore: Firebase - RemoteConfig Custom Key 를 설정합니다.
  /// - Returns: AppUpdateStatus - `valid`, `forceUpdate`, `optionalUpdate`
  public func fetchAppUpdateStatus() async throws -> AppUpdateStatus {
    return try await withCheckedThrowingContinuation({ [weak self] (continuation: CheckedContinuation<AppUpdateStatus, Error>) in
      RemoteConfig.remoteConfig()
        .fetch(withExpirationDuration: 0) { [weak self] (status, error) in
          guard let self else {
            continuation.resume(throwing: LaunchingServiceError.unknown)
            return
          }
          if let error {
            continuation.resume(throwing: error)
            return
          }
          
          RemoteConfig.remoteConfig().activate()
          
          do {
            let releaseVersion = try MainBundle().releaseVersion()
            let launching = try RemoteConfigParser().parse()
            let updateState = self.compare(releaseVersion: releaseVersion, launching: launching)
            
            continuation.resume(returning: updateState)
          } catch {
            continuation.resume(throwing: error)
          }
        }
    })
  }
}

extension DependencyValues {
  public var remoteConfigRegisterdKeys: RemoteConfigRegisterdKeys {
    get { self[RemoteConfigRegisterdKeys.self] }
    set { self[RemoteConfigRegisterdKeys.self] = newValue }
  }
}

extension RemoteConfigRegisterdKeys: DependencyKey {
  public static var liveValue = RemoteConfigRegisterdKeys()
}
