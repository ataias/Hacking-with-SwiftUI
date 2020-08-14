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

    static let prospectsFile = { () -> URL in
        let prefix = FileManager.documentsDirectory
        let userDir = prefix.appendingPathComponent("prospectsFile.json")
        return userDir
    }()

    @Published private(set) var people: [Prospect]

    init() {
        if let prospects: [Prospect] = FileManager.decode(Self.prospectsFile) {
            self.people = prospects
            return
        }
        self.people = []
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }

    private func save() {
        do {
            let encoded = try JSONEncoder().encode(self.people)
            try encoded.write(to: Self.prospectsFile, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print(error.localizedDescription)
        }
    }

    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
