//
//  BlackListTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

@MainActor
final class BlackListTests: LaunchingServiceTests {
  func testBlackListRequired_0() async throws {
    await tests(releaseVersion: "2.3.10",
                    forceVersion: "0.0.9",
                    optionalUpdate: "0.0.5",
                    blackListVersions: ["2.3.9", "2.3.10", "2.3.11"],
                    notice: nil,
                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testBlackListRequired_1() async throws {
    await tests(releaseVersion: "12.3",
                    forceVersion: "11.0.9",
                    optionalUpdate: "15.0.5",
                    blackListVersions: ["12.3.0", "12.3", "12"],
                    notice: nil,
                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testBlackListRequired_2() async throws {
    await tests(releaseVersion: "1.0.10",
                    forceVersion: "0.0.9",
                    optionalUpdate: "0.0.5",
                    blackListVersions: ["2.3.9", "2.3.10", "1.0.10"],
                    notice: nil,
                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testBlackListRequired_3() async throws {
    await tests(releaseVersion: "0.3.10",
                    forceVersion: "0.0.9",
                    optionalUpdate: "0.0.5",
                    blackListVersions: ["0.3.10"],
                    notice: nil,
                    isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testBlackListVersionValid_1() async throws {
    await tests(releaseVersion: "2.0.0",
                    forceVersion: "2.0.0",
                    optionalUpdate: "",
                    blackListVersions: ["1.9.1"],
                    notice: nil,
                    isEqualStatus: .valid)
  }
  
  func testBlackListVersionValid_2() async throws {
    await tests(releaseVersion: "1.0.0",
                    forceVersion: "0.0.9",
                    optionalUpdate: "0",
                    blackListVersions: ["1.0.1"],
                    notice: nil,
                    isEqualStatus: .valid)
  }
  
  func testBlackListVersionValid_3() async throws {
    await tests(releaseVersion: "1.0.0",
                    forceVersion: "0.1",
                    optionalUpdate: "",
                    blackListVersions: [],
                    notice: nil,
                    isEqualStatus: .valid)
  }
  
  func testBlackListVersionValid_4() async throws {
    await tests(releaseVersion: "1.0.0",
                    forceVersion: "0.1",
                    optionalUpdate: "",
                    blackListVersions: [""],
                    notice: nil,
                    isEqualStatus: .valid)
  }
}
