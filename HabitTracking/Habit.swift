//
//  Habit.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 29/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id = UUID()
    let creationDate = Date()
    let name: String
    // TODO How to track which days the habit occurred?

    // TODO Idea: show statistics. how often habit happened in previous week, month,...
}

// TODO How to select the date the habits occurred?
// TODO Calendar view? https://swiftwithmajid.com/2020/05/06/building-calendar-without-uicollectionview-in-swiftui/
// TODO The main screen could have a simple toggle to mark the habits as occurred or not (current day, previous day?)
// TODO Habits that did not happen yet could be marked differently
