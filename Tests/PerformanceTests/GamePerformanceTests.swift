//
//  GamePerformanceTests.swift
//  SwiftSummonShogi
//
//  Created by 森田健太 on 9/7/24.
//


import XCTest
import SwiftShogi

final class GamePerformanceTests: XCTestCase {
    func testValidMoves() {
        let game = Game(sfen: .default)
        measure {
            _ = game.validMoves()
        }
    }
}
