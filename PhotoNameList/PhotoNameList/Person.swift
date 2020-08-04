//
//  Person.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Person: Codable, Identifiable {
    let id: UUID
    let createdAt: Date
    let firstName: String
    let lastName: String
    let photoId: UUID

    init(firstName: String, lastName: String, photoId: UUID) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.createdAt = Date()
        self.photoId = photoId
    }
}
