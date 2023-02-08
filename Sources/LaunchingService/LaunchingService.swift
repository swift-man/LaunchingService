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
  
  public init(keyStore: LaunchingServiceKeyStore) {
    self.remoteConfigParser = RemoteConfigParser(keyStore: keyStore)
  }
  
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
