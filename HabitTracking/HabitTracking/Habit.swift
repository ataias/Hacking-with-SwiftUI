//
//  Habit.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 29/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable, Hashable {
    let id: UUID
    let creationDate: Date
    let name: String
    let type: String
    let notes: String

    init(name: String, type: String, notes: String) {
        self.id = UUID()
        self.creationDate = Date()
        self.name = name
        self.type = type
        self.notes = notes
    }

    // TODO How to track which days the habit occurred?

    // TODO Idea: show statistics. how often habit happened in previous week, month,...

    // TODO Idea: maybe add a frequency to the habit? Maybe some are just every two days or three
}
