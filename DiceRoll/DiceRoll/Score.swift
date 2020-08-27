//
//  Score.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 27/08/20.
//

import Foundation

struct Score: Identifiable {
    var id: Int
    var date: Date
    var rolls: [Roll]

}

struct Roll: Identifiable {
    var id: Int
    var value: Int
    var maxValue: Int
}
