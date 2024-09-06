# SwiftSummonShogi


<p align="center">
    <img src="Logo.png" width="400" max-width="90%" alt=“SwiftShogi” />
</p>

<p align="center">
    <a href="https://github.com/morikentiger/SwiftSummonShogi/actions">
        <img src="https://github.com/morikentiger/SwiftSummonShogi/workflows/CI/badge.svg" alt="Workflow Status" />
    </a>
    <a href="https://swift.org/download/">
        <img src="https://img.shields.io/badge/swift-5.1-orange.svg" alt="Swift Version" />
    </a>
    <img src="https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg?style=flat" alt="Platforms" />
    <a href="https://swift.org/package-manager">
        <img src="https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat" alt="Swift Package Manager" />
    </a>
    <a href="https://twitter.com/kuromoriken">
        <img src="https://img.shields.io/badge/twitter-@kuromoriken-blue.svg?style=flat" alt="Twitter: @kuromoriken" />
    </a>
</p>
This package is written in Swift for SummonShogi.

SwiftSummonShogi is a pure Swift Summon shogi library with game management, bitboard-based board representation, and move generation/validation.

## Features

- [x] Game management
- [x] Board representation
- [x] Move generation/validation
- [x] SFEN parsing
- [ ] KIF parsing
- [ ] Pretty printing

## Example

To understand how to develop apps using SwiftShogi, you can refer to the following app.

- [SwiftUISummonShogi](https://github.com/morikentiger/SwiftUISummonShogi) \- An example  summon shogi app using SwiftUI

## Usage

Initialize a game with [SFEN](https://en.wikipedia.org/wiki/Shogi_notation#SFEN):

```swift
var game = Game(sfen: .default)
```

To get all valid moves, use the `validMoves()` method, and to get valid moves for a specified piece, use the `validMoves(from:piece:)` method:

```swift
let moves = game.validMoves()

let pieceMoves = game.validMoves(
    from: .board(.twoG),
    piece: Piece(kind: .pawn(.normal), color: .black)
)
```

You can perform a move by calling the game's `perform(_:)` method:

```swift
let move = Move(
    source: .board(.twoG),
    destination: .board(.twoF),
    piece: Piece(kind: .pawn(.normal), color: .black)
)
try game.perform(move)
```

## Installation

Add the SwiftShogi package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
    name: "YourProject",
    dependencies: [
        .package(
            url: "https://github.com/morikentiger/SwiftSummonShogi",
            from: "0.1.0"
        ),
    ]
)
```

Then run the `swift build` command to build your project.

## License

MIT

## Contact

Kenta Morita ([@kuromoriken](https://twitter.com/kuromoriken))
