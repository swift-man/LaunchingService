//
//  AppVersionFetchService.swift
//  
//
//  Created by SwiftMan on 2023/01/31.
//

import Foundation
import FirebaseRemoteConfig
import Firebase

public class AppVersionFetchService {
  let checker: AppVersionCheckService
  
  public init(keyStore: AppVersionServiceKeyStore) {
    self.checker = AppVersionCheckService(keyStore: keyStore)
  }
  
  public func fetchAppVersion() async throws -> ResultAppVersion {
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
            continuation.resume(returning: try self.checker.compareReleaseVersion())
          } catch {
            continuation.resume(throwing: error)
          }
        }
    })
  }
}
