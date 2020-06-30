//
//  ContentView.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 29/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

class Storage: ObservableObject {

    init() {
        self.habits = [Habit(name: "Strength Exercise")]
        self.activityLogs = [
            ActivityLog(habitId: habits[0].id, date: Date(), notes: "Nothing really")
        ]
    }

    @Published var habits: [Habit]
    @Published var activityLogs: [ActivityLog]
}

struct ContentView: View {
    @ObservedObject var storage = Storage()
    @State private var showingAddHabit = false

    private var habits: [Habit] {
        return storage.habits
    }

    private var activityLogs: [ActivityLog] {
        return storage.activityLogs
    }

    var body: some View {
        NavigationView {
            // TODO Besides showing the habits, add an extra element on top that shows overall statistics like number of entries logged in the day, week,...
            List() {
                ForEach(habits) { habit in
                    // TODO filter activity logs
                    NavigationLink(destination: HabitView(habit: habit, activityLogs: activityLogs)) {
                        VStack(alignment: .leading) {
                            Text(habit.name)
                                .font(.headline)
                        }
                    }

                }
            }
            .navigationBarTitle("HabitTracking")
            .navigationBarItems(
                leading: EditButton(),
                // TODO Is this a SwiftUI? The button is unresponsive. The first time it works and you can add an item, but afterwards it stops working. I tried investigating if variables were being set correctly, but they seemed ok, except that the button is not triggered anymore after adding an item.
                trailing: Button(action: {
                    self.showingAddHabit = true
                    print(self.showingAddHabit)
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddHabit) {
                    AddHabitView(habits: self.habits)
            }

        }

    }

}

struct ContentView_Previews: PreviewProvider {
//    static let habits = [Habit(name: "Strength Exercise")]
//    static let activityLogs =


    static var previews: some View {
        ContentView()
    }
}
