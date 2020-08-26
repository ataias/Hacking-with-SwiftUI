//
//  DiceRollApp.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 25/08/20.
//

import SwiftUI

@main
struct DiceRollApp: App {
    let context = PersistentContainer.persistentContainer.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, context)

        }
    }
}
