//
//  RemoteConfigParser.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Dependencies

final class RemoteConfigParser: Sendable {
  func parse() throws -> Launching {
    do {
      @Dependency(\.remoteConfigRegisterdKeys)
      var remoteConfigRegisterdKeys
      
      let forceParser = RemoteConfigForceUpdateParser(keyStore: remoteConfigRegisterdKeys)
      let noticeParser = RemoteConfigNoticeParser(keyStore: remoteConfigRegisterdKeys)
      
      let forceUpdate = try forceParser.parseAppUpdateInfo()
      
      let optionalParser = RemoteConfigOptionalUpdateParser(keyStore: remoteConfigRegisterdKeys)
      let optionalUpdate = try optionalParser.parseAppUpdateInfo()
      
      let notice = noticeParser.parseNotice()
      
      return Launching(forceUpdate: forceUpdate,
                       optionalUpdate: optionalUpdate,
                       blackListVersions: forceParser.parseBlackListVersions,
                       notice: notice)
    } catch {
      throw error
    }
  }
}
