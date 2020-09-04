//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 30/08/20.
//

import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"

    init() {
        resorts = Set(UserDefaults.standard.stringArray(forKey: saveKey) ?? [])
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.setValue(Array(resorts), forKey: saveKey)
    }
}
