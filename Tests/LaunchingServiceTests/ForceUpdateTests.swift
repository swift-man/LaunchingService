//
//  ForceUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import Testing
import LaunchingService

@Suite("ForceUpdate")
@MainActor
struct ForceUpdateTests {
  @Test func allVersionIsEmpty_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func forceVersionRequired_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  @Test func forceVersionRequired_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.1",
                                    optionalUpdate: "2.0.0",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  @Test func forceVersionRequired_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0",
                                    forceVersion: "2.0.5",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  @Test func forceVersionValid_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "1.0.0",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func forceVersionValid_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
  
  @Test func forceVersionValid_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.1",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
}
