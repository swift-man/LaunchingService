//
//  DateProviderMock.swift
//
//
//  Created by SwiftMan on 2026/07/08.
//

import Foundation
@testable import LaunchingService

struct DateProviderMock: DateProviding {
  let now: Date
}
