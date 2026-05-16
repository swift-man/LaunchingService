//
//  LaunchingService.swift
//
//
//  Created by SwiftMan on 2023/01/31.
//

/// 앱을 구성하기 전 외부로 부터 설정을 가져와 앱 상태를 반환하는 서비스 입니다.
@available(iOS 15.0, macOS 12, tvOS 15, watchOS 8.0, *)
public final class LaunchingService: LaunchingInteractable, Sendable {
  private let remoteConfigClient: any RemoteConfigClient
  private let appVersionProvider: any AppReleaseVersionProviding

  /// Creates an instance with the given alignment.
  public init() {
    self.remoteConfigClient = FirebaseRemoteConfigClient()
    self.appVersionProvider = MainBundleReleaseVersionProvider()
  }

  init(remoteConfigClient: any RemoteConfigClient,
       appVersionProvider: any AppReleaseVersionProviding) {
    self.remoteConfigClient = remoteConfigClient
    self.appVersionProvider = appVersionProvider
  }

  /// Firebase - RemoteConfig 의 값을 가져오고 계산 된 앱의 상태를 반환 합니다.
  ///
  /// - Returns: ``AppUpdateStatus`` - `valid`, `forceUpdate`, `optionalUpdate`
  /// - Throws: ``LaunchingServiceError``
  public func fetchAppUpdateStatus() async throws -> AppUpdateStatus {
    do {
      try await remoteConfigClient.fetchAndActivate()
    } catch {
      // Continue with the currently active or default RemoteConfig values.
    }

    let releaseVersion = try appVersionProvider.releaseVersion()
    let launching = RemoteConfigParser(valueProvider: remoteConfigClient).parse()
    return compare(releaseVersion: releaseVersion, launching: launching)
  }
}
