//
//  LaunchingService.swift
//
//
//  Created by SwiftMan on 2023/01/31.
//

import Firebase
@preconcurrency import FirebaseRemoteConfig
import Dependencies

/// 앱을 구성하기 전 외부로 부터 설정을 가져와 앱 상태를 반환하는 서비스 입니다.
@available(iOS 15.0, macOS 12, tvOS 13, watchOS 6.0, *)
public final class LaunchingService: LaunchingInteractable, Sendable {
  /// Creates an instance with the given alignment.
  public init() {
  }

  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  ///
  /// - Returns: ``AppUpdateStatus`` - `valid`, `forceUpdate`, `optionalUpdate`
  /// - Throws: ``LaunchingServiceError``
  public func fetchAppUpdateStatus() async throws -> AppUpdateStatus {
    let remoteConfig = RemoteConfig.remoteConfig()
    return try await withCheckedThrowingContinuation { continuation in
      remoteConfig.fetch(withExpirationDuration: 0) { _, error in
        if let error {
          continuation.resume(throwing: error)
          return
        }

        remoteConfig.activate { _, error in
          if let error {
            continuation.resume(throwing: error)
            return
          }

          do {
            let releaseVersion = try MainBundle().releaseVersion()
            let launching = try RemoteConfigParser().parse()
            let updateState = self.compare(releaseVersion: releaseVersion, launching: launching)

            continuation.resume(returning: updateState)
          } catch {
            continuation.resume(throwing: error)
          }
        }
      }
    }
  }
}
