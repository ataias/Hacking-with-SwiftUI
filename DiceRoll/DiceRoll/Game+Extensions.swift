//
//  Game+Extensions.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 26/08/20.
//

import Foundation
import CoreData

extension Game {

    public var rollsArray: [DiceRoll] {
        let set = rolls as? Set<DiceRoll> ?? []
        return set.sorted {
            $0.sequence < $1.sequence
        }
    }

}
