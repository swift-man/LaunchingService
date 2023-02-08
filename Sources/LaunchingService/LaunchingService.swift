//
//  LaunchingService.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation
import FirebaseRemoteConfig
import Firebase

public final class LaunchingService: Sendable {
  let remoteConfigParser: RemoteConfigParser
  
  public init(keyStore: AppVersionServiceKeyStore) {
    self.remoteConfigParser = RemoteConfigParser(keyStore: keyStore)
  }
  
  public func fetchLaunchingConfig() async throws -> ResultAppVersion {
    return try await withCheckedThrowingContinuation({ [weak self] (continuation: CheckedContinuation<ResultAppVersion, Error>) in
      RemoteConfig.remoteConfig()
        .fetch(withExpirationDuration: 0) { [weak self] (status, error) in
          guard let self else {
            continuation.resume(throwing: AppVersionServiceError.unknown)
            return
          }
          if let error {
            continuation.resume(throwing: error)
            return
          }
          
          RemoteConfig.remoteConfig().activate()
          
          do {
            let launching = try self.remoteConfigParser.parse()
            let releaseVersionNumber = try AppVersionService().releaseVersionNumber()
            
            let appVersionChecker = AppVersionChecker()
            var updateState = appVersionChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                        launching: launching)
            
            if updateState == .success {
              let blackListVersionChecker = BlackListVersionChecker()
              updateState = blackListVersionChecker.compare(releaseVersionNumber: releaseVersionNumber,
                                                            launching: launching)
            }
            
            continuation.resume(returning: updateState)
          } catch {
            continuation.resume(throwing: error)
          }
        }
    })
  }
}
