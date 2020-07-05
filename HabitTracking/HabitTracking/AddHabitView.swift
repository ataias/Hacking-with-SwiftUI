//
//  AddHabitView.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 30/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct AddHabitView: View {
    @State private var name = "My New Habit"
    @State private var type = "Personal"
    @State private var notes = ""
    @ObservedObject var storage: Storage
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    // Notice we can use Self with upper case S to refer to a static thing
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Notes", text: $notes)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(trailing: Button("Save") {
                let habit = Habit(name: self.name, type: self.type, notes: self.notes)
                self.storage.habits.append(habit)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }

}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(storage: Storage(completed: true))
    }
}
