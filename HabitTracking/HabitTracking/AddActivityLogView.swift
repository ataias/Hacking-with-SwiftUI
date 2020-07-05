//
//  AddActivityLogView.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 03/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct AddActivityLogView: View {

    @State var habit: Habit
    @ObservedObject var storage: Storage
    @State var completed: Bool = true
    @State var notes: String = ""

    @State private var date = Date()

    @Environment(\.presentationMode) var presentationMode

    var dateFormatter: DateFormatter {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           return formatter
       }

    var body: some View {
        NavigationView {
            Form {
                // REVIEW Habit Field is a picker whose default is the habit given but user can select any from storage

                Section(header:
                    Text("Habit").font(.headline)
                ) {
                    Picker(habit.name, selection: $habit) {
                        // Notice we can use Self with upper case S to refer to a static thing
                        ForEach(storage.habits) {
                            Text($0.name)
                        }
                    }
                    Toggle(isOn: $completed, label: {
                        Text("Completed")
                    })

                }

                Section(header: Text("DATE"), content: {
                    DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                        Text("Select a date")
                    }

                })

                Section(header: Text("Notes"), content: {
                    TextField("", text: $notes)
                })



                // TODO Idea: what about user goes to a screen just to fill habits? We send them habits to track for today one by one and he can skip or fill
                // TODO Add a date picker; default is today but user can change
            }
            .navigationBarTitle("Add activity log")
            .navigationBarItems(trailing: Button("Save") {
                let activityLog = ActivityLog(id: UUID(), habitId: self.habit.id, date: self.date, completed: self.completed, notes: self.notes)
                self.storage.activityLogs.append(activityLog)
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddActivityLogView_Previews: PreviewProvider {
    static var storage = Storage(completed: true)

    static var previews: some View {
        AddActivityLogView(habit: storage.habits[0], storage: storage)
    }
}
