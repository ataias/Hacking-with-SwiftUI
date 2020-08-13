//
//  Prospects.swift
//  HotProspects
//
//  Created by Ataias Pereira Reis on 10/08/20.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""

    /// isContacted should only be set in this file so that we can enforce sending the UI a notification of update
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {

    static let saveKey = "SavedData"
    @Published private(set) var people: [Prospect]

    init() {
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
