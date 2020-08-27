//
//  FetchedResults+Game+Extensions.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 27/08/20.
//

import Foundation
import SwiftUI

extension FetchedResults where Element == Game {

    var scores: [Score] {
        self
            .enumerated()
            .map { (i: Int, g: Game) -> Score in

                let diceRolls: [DiceRoll] = g.rollsArray

                let rolls: [Roll] = diceRolls.map { d in
                    Roll(id: Int(d.sequence),
                         value: Int(d.value),
                         maxValue: Int(d.maxValue)
                    )
                }

                return (
                    Score(id: i,
                          date: g.date!,
                          rolls: rolls
                    )
                )
            }
    }
}
