//
//  LinuxMain.swift
//  SwiftSummonShogi
//
//  Created by 森田健太 on 9/7/24.
//


import XCTest

import PerformanceTests
import SwiftShogiTests

var tests = [XCTestCaseEntry]()
tests += PerformanceTests.__allTests()
tests += SwiftShogiTests.__allTests()

XCTMain(tests)
