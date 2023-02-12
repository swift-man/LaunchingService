//
//  ForceUpdateTests.swift
//  
//
//  Created by SwiftMan on 2023/02/11.
//

import XCTest
import LaunchingService

final class ForceUpdateTests: LaunchingServiceTests {
  func testAllVersionIsEmpty_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testForceVersionRequired_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.1",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testForceVersionRequired_2() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.1",
                optionalUpdate: "2.0.0",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testForceVersionRequired_3() async throws {
    await tests(releaseVersion: "1.0",
                forceVersion: "2.0.5",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .forcedUpdateRequired(.mock))
  }
  
  func testForceVersionValid_1() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "1.0.0",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testForceVersionValid_2() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "0.0.9",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
  
  func testForceVersionValid_3() async throws {
    await tests(releaseVersion: "1.0.0",
                forceVersion: "0.1",
                optionalUpdate: "",
                blackListVersions: [],
                notice: nil,
                isEqualStatus: .valid)
  }
}
