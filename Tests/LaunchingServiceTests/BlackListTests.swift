//
//  BlackListTests.swift
//
//
//  Created by SwiftMan on 2023/02/11.
//

import Testing
import LaunchingService

@Suite("BlackList")
@MainActor
struct BlackListTests {
  @Test func blackListRequired_0() async throws {
    try await expectAppUpdateStatus(releaseVersion: "2.3.10",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0.0.5",
                                    blackListVersions: ["2.3.9", "2.3.10", "2.3.11"],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }

  @Test func blackListRequired_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "12.3",
                                    forceVersion: "11.0.9",
                                    optionalUpdate: "15.0.5",
                                    blackListVersions: ["12.3.0", "12.3", "12"],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }

  @Test func blackListRequired_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.10",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0.0.5",
                                    blackListVersions: ["2.3.9", "2.3.10", "1.0.10"],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }

  @Test func blackListRequired_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "0.3.10",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0.0.5",
                                    blackListVersions: ["0.3.10"],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }

  @Test func blackListRequiredWithWhitespace() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.2.0",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0.0.5",
                                    blackListVersions: ["1.0.0", " 1.2.0 ", "2.0.0"],
                                    notice: nil,
                                    isEqualStatus: .forcedUpdateRequired(.mock))
  }

  @Test func blackListVersionValid_1() async throws {
    try await expectAppUpdateStatus(releaseVersion: "2.0.0",
                                    forceVersion: "2.0.0",
                                    optionalUpdate: "",
                                    blackListVersions: ["1.9.1"],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }

  @Test func blackListVersionValid_2() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.0.9",
                                    optionalUpdate: "0",
                                    blackListVersions: ["1.0.1"],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }

  @Test func blackListVersionValid_3() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.1",
                                    optionalUpdate: "",
                                    blackListVersions: [],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }

  @Test func blackListVersionValid_4() async throws {
    try await expectAppUpdateStatus(releaseVersion: "1.0.0",
                                    forceVersion: "0.1",
                                    optionalUpdate: "",
                                    blackListVersions: [""],
                                    notice: nil,
                                    isEqualStatus: .valid)
  }
}
