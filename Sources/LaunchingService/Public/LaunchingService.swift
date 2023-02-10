//
//  LaunchingService.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Firebase
import FirebaseRemoteConfig

public protocol LaunchingInteractable: AnyObject {
  func fetchAppStatus(keyStore: LaunchingServiceKeyStore) async throws -> AppUpdateStatus
}

/// 앱을 구성하기 전 외부로 부터 설정을 가져와 앱 상태를 반환하는 서비스 입니다.
public final class LaunchingService: LaunchingInteractable, Sendable {
  private let remoteConfigParser = RemoteConfigParser()
  
  /// Creates an instance with the given alignment.
  public init() {
  }
  
  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  /// - Parameter keyStore: Firebase - RemoteConfig Custom Key 를 설정합니다.
  /// - Returns: AppUpdateStatus - `valid`, `forceUpdate`, `optionalUpdate`
  public func fetchAppStatus(keyStore: LaunchingServiceKeyStore = LaunchingServiceKeyStore()) async throws -> AppUpdateStatus {
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
            let launching = try self.remoteConfigParser.parse(keyStore: keyStore)
            let releaseVersion = try MainBundle().releaseVersion()
            let updateState = try self.compare(releaseVersion: releaseVersion, launching: launching)
            
            continuation.resume(returning: updateState)
          } catch {
            continuation.resume(throwing: error)
          }
        }
    })
  }
  
  private func compare(releaseVersion: String, launching: Launching) throws -> AppUpdateStatus {
    let updateVersionChecker = VersionUpdateChecker()
    let updateState = updateVersionChecker.compare(releaseVersionNumber: releaseVersion,
                                                   launching: launching)
    
    return updateState
  }
}
