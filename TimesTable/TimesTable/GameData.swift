//
//  GameData.swift
//  TimesTable
//
//  Created by Ataias Pereira Reis on 14/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

/// A math challenge
import SwiftUI

struct MathChallenge {
    let left: Int
    let right: Int
    let operation: String
    let answer: Int
}

struct AnswerOption {
    let value: Int
    let correct: Bool
    var color: Color
}

struct Score {
    var count: Int
    var totalSoFar: Int
    var correct: Int

    var wrong: Int {
        totalSoFar - correct
    }

    /// The number of games still to be played
    var leftGames: Int {
        count - totalSoFar
    }

    func toString() -> String {
        return "\(correct)/\(count)"
    }
}

/// The maximum value used in the times table challenges.
let maxTimesTable = 12

/// The game view is represented as a grid. This variable defines how many rows this grid has.
let totalGameRows = 3

/// The game view is represented as a grid. This variable defines how many columns this grid has.
let totalGameColumns = 2

/// The game view is represented as a grid with a set of answers the user should should from. To fill the grid with answers, we compute how many we need with this variable.
let totalGameAnswers = totalGameRows * totalGameColumns
