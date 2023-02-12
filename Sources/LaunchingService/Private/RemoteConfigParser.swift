//
//  RemoteConfigParser.swift
//  
//
//  Created by SwiftMan on 2023/02/10.
//

import Dependencies

final class RemoteConfigParser: Sendable {
  func parse(keyStore: RemoteConfigRegisterdKeys) throws -> Launching {
    do {
      let forceParser = RemoteConfigForceUpdateParser(keyStore: keyStore)
      let noticeParser = RemoteConfigNoticeParser(keyStore: keyStore)
      
      let forceUpdate = try forceParser.parseAppUpdateInfo()
      
      let optionalParser = RemoteConfigOptionalUpdateParser(keyStore: keyStore)
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
