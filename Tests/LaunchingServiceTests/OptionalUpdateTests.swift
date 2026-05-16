//
//  OptionalUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Testing
import LaunchingService

@Suite("OptionalUpdate")
@MainActor
struct OptionalUpdateTests {
  @Test func dataOptionalVersionRequired_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "1.0.1",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  @Test func dataOptionalVersionRequired_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "2.0.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "2.0.1",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .optionalUpdateRequired(.mock))
  }
  
  @Test func dataOptionalVersionRequired_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "10.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "10.0.1",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .optionalUpdateRequired(.mock))
  }
  
  @Test func dataOptionalVersionValid_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.0",
                                    optionalUpdate: "0.9.0",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func dataOptionalVersionValid_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0.9.2",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func dataOptionalVersionValid_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.1",
                                    optionalUpdate: "0.5.1",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
}
