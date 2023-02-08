//
//  LaunchingService.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Firebase
import FirebaseRemoteConfig

/// 앱을 구성하기 전 외부로 부터 설정을 가져와 앱 상태를 반환하는 서비스 입니다.
public final class LaunchingService: Sendable {
  let remoteConfigParser: RemoteConfigParser
  
  /// Creates an instance with the given alignment.
  /// - Parameter keyStore: Firebase - RemoteConfig Custom Key 를 설정합니다.
  public init(keyStore: LaunchingServiceKeyStore) {
    self.remoteConfigParser = RemoteConfigParser(keyStore: keyStore)
  }
  
  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  /// - Returns: AppUpdateStatus - `valid`, `forceUpdate`, `optionalUpdate`
  public func fetchLaunchingConfig() async throws -> AppUpdateStatus {
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
            let launching = try self.remoteConfigParser.parse()
            let updateState = try self.compare(launching: launching)
            
            continuation.resume(returning: updateState)
          } catch {
            continuation.resume(throwing: error)
          }
        }
    })
  }
  
  func compare(launching: Launching) throws -> AppUpdateStatus {
    do {
      let releaseVersionNumber = try MainBundle().releaseVersion()
      
      let updateVersionChecker = UpdateVersionChecker()
      var updateState = updateVersionChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                  launching: launching)
      
      if updateState == .valid {
        let blackListVersionChecker = BlackListVersionChecker()
        updateState = blackListVersionChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                      launching: launching)
      }
      
      return updateState
    } catch {
      throw error
    }
  }
}
