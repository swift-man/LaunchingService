//
//  OptionalUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

@MainActor
final class OptionalUpdateTests: LaunchingServiceTests {
  func testDataOptionalVersionRequired_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.1",
                optionalUpdate: "1.0.1",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testDataOptionalVersionRequired_2() async throws {
    await tests(releaseVersion: "2.0.0",
                forceVersion: "1.0.1",
                optionalUpdate: "2.0.1",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .optionalUpdateRequired(.mock))
  }
  
  func testDataOptionalVersionRequired_3() async throws {
    await tests(releaseVersion: "10.0",
                forceVersion: "1.0.1",
                optionalUpdate: "10.0.1",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .optionalUpdateRequired(.mock))
  }
  
  func testDataOptionalVersionValid_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.0",
                optionalUpdate: "0.9.0",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testDataOptionalVersionValid_2() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "0.0.9",
                optionalUpdate: "0.9.2",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testDataOptionalVersionValid_3() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "0.1",
                optionalUpdate: "0.5.1",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
}
