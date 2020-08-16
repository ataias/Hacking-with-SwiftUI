//
//  Card.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 16/08/20.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String

    static var example: Card {
        Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
    }
}
