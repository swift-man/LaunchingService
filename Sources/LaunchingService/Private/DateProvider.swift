//
//  DateProvider.swift
//
//
//  Created by SwiftMan on 2026/07/08.
//

import Foundation

protocol DateProviding: Sendable {
  var now: Date { get }
}

struct SystemDateProvider: DateProviding {
  var now: Date {
    Date()
  }
}
