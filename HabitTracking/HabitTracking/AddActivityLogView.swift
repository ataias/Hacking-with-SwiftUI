//
//  AddActivityLogView.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 03/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct AddActivityLogView: View {
    let habit: Habit

    @State private var name = "My New Habit"
    @State private var type = "Personal"
    @State private var notes = ""
    @ObservedObject var storage: Storage
    @Environment(\.presentationMode) var presentationMode

    static let types = ["Business", "Personal"]

    var body: some View {
        NavigationView {
            Form {
                // TODO Habit Field is a picker whose default is the habit given but user can select any from storage
                // TODO Idea: what about user goes to a screen just to fill habits? We send them habits to track for today one by one and he can skip or fill
                // TODO Add a date picker; default is today but user can change
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

struct AddActivityLogView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityLogView()
    }
}
