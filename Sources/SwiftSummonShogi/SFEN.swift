//
//  SFEN.swift
//  SwiftSummonShogi
//
//  Created by 森田健太 on 9/7/24.
//


/// SFEN as an extension of Forsyth–Edwards Notation (FEN) used for describing board positions of shogi games.
///
/// - SeeAlso:
/// [SFEN (Wikipedia)](https://en.wikipedia.org/wiki/Shogi_notation#SFEN)
public struct SFEN {
//    nonisolated(unsafe) public static let `default` = Self(string: "lnsgkgsnl/1r5b1/ppppppppp/9/9/9/PPPPPPPPP/1B5R1/LNSGKGSNL b -")!
    nonisolated(unsafe) public static let `default` = Self(string: "4k4/9/9/9/9/9/9/9/4K4 b -")!

    public let board: Board
    public let color: Color
    public let capturedPieces: [Piece]

    public init?(string: String) {
        guard
            let fields = Fields(string: string),
            let board = fields.board,
            let color = fields.color,
            let pieces = fields.capturedPieces
            else { return nil }
        self.board = board
        self.color = color
        self.capturedPieces = pieces
    }
}

extension SFEN {
    struct Fields {
        private let boardString: String
        private let colorString: String
        private let capturedPiecesString: String

        init?(string: String) {
            let strings = string.split(separator: SFEN.fieldSeparator).map(String.init)
            guard strings.count == SFEN.numberOfFields else { return nil }
            self.boardString = strings[0]
            self.colorString = strings[1]
            self.capturedPiecesString = strings[2]
        }
    }
}

extension SFEN.Fields {
    var board: Board? {
        let rankStrings = boardString.split(separator: SFEN.rankSeparator)
        guard rankStrings.count == Rank.allCases.count else { return nil }

        var board = Board()
        for (rank, string) in zip(Rank.allCases, rankStrings) {
            var squares = Square.cases(at: rank).makeIterator()
            var hasPrefix = false
            for character in Array(string) {
                switch character {
                case _ where SFEN.pieceCharacters.contains(character) || hasPrefix:
                    guard
                        let square = squares.next(),
                        let piece = Piece(character: character, isPromoted: hasPrefix)
                        else { return nil }
                    board[square] = piece
                    hasPrefix = false
                case SFEN.promotionPrefix:
                    hasPrefix = true
                case _ where SFEN.digitCharacters.contains(character):
                    let skipCount = Int(String(character))!
                    for _ in (0 ..< skipCount) {
                        guard squares.next() != nil else { return nil }
                    }
                default:
                    return nil
                }
            }
            // Checks that no indefinite square exists.
            guard squares.next() == nil else { return nil }
        }
        return board
    }

    var color: Color? {
        guard colorString.count == 1 else { return nil }
        return Color(character: Character(colorString))
    }

    var capturedPieces: [Piece]? {
        var pieces = [Piece]()

        if capturedPiecesString == String(SFEN.emptyCharacter) {
            return pieces
        }

        var numberOfPieces = 1
        for (index, character) in Array(capturedPiecesString).enumerated() {
            let isLast = index == capturedPiecesString.count - 1
            switch character {
            case _ where SFEN.pieceCharacters.contains(character) || numberOfPieces > 1:
                guard let piece = Piece(character: character, isPromoted: false) else { return nil }
                (0 ..< numberOfPieces).forEach { _ in
                    pieces.append(piece)
                }
                numberOfPieces = 1
            case _ where SFEN.digitCharacters.contains(character) && !isLast:
                numberOfPieces = Int(String(character))!
            default:
                return nil
            }
        }
        return pieces
    }
}

private extension SFEN {
    static let numberOfFields = 3
    static let fieldSeparator = Character(" ")
    static let rankSeparator = Character("/")
    static let promotionPrefix = Character("+")
    static let emptyCharacter = Character("-")
    static let pieceCharacters = Array("KRBGSNLPkrbgsnlp")
    static let digitCharacters = Array("123456789")
}
