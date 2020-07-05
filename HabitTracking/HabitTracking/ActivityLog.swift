//
//  ActivityLog.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 05/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct ActivityLog: Codable, Identifiable {
    let id: UUID
    let habitId: UUID
    let date: Date
    let completed: Bool
    let notes: String

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: date)
    }

}
