//
//  RemoteConfigParser.swift
//
//
//  Created by SwiftMan on 2023/02/10.
//

import Dependencies

final class RemoteConfigParser: Sendable {
  private let valueProvider: any RemoteConfigValueProviding

  init(valueProvider: any RemoteConfigValueProviding = FirebaseRemoteConfigClient()) {
    self.valueProvider = valueProvider
  }

  func parse() -> Launching {
    @Dependency(\.remoteConfigRegisterdKeys)
    var remoteConfigRegisterdKeys

    let forceParser = RemoteConfigForceUpdateParser(keyStore: remoteConfigRegisterdKeys,
                                                    valueProvider: valueProvider)
    let noticeParser = RemoteConfigNoticeParser(keyStore: remoteConfigRegisterdKeys,
                                                valueProvider: valueProvider)

    let forceUpdate = forceParser.parseAppUpdateInfo()

    let optionalParser = RemoteConfigOptionalUpdateParser(keyStore: remoteConfigRegisterdKeys,
                                                          valueProvider: valueProvider)
    let optionalUpdate = optionalParser.parseAppUpdateInfo()

    let notice = noticeParser.parseNotice()

    return Launching(forceUpdate: forceUpdate,
                     optionalUpdate: optionalUpdate,
                     blackListVersions: forceParser.parseBlackListVersions(),
                     notice: notice)
  }
}
