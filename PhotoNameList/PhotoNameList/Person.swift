//
//  Person.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Person: Codable, Identifiable, Comparable {
    let id: UUID
    let createdAt: Date
    let firstName: String
    let lastName: String
    let photoId: UUID
    /// A helper note of how the user met this person
    let notes: String

    init(firstName: String, lastName: String, photoId: UUID, notes: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = Date()
        self.photoId = photoId
        self.notes = notes
    }

    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.firstName+lhs.lastName < rhs.firstName+rhs.lastName
    }
}
