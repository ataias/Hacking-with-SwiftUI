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
        let habit = Habit(name: "Strength Exercise", type: "Personal", notes: "")
        habits = [habit]
        activityLogs = [
            ActivityLog(habitId: habit.id, date: Date(), notes: "Nothing really")
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
            List {
                ForEach(habits) { habit in
                        NavigationLink(destination: HabitView(habit: habit, activityLogs: self.activityLogs)) {
                            HStack {
                                Circle()
                                    .frame(width: 20, height: 20, alignment: .leading)
                                    .foregroundColor(self.getColor(habit: habit))
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .font(.headline)
                                    Text(habit.type)
                                        .font(.subheadline)
                                }
                                Spacer()

                            }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("HabitTracking")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    self.showingAddHabit = true
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddHabit) {
                    AddHabitView(storage: self.storage)
            }

        }

    }

    func getColor(habit: Habit) -> Color {
        let oneWeekAgo = Date().addingTimeInterval(-7*24*60*60)
        let activityLogs = self.activityLogs.filter { $0.habitId == habit.id && $0.date >= oneWeekAgo }
        let latestActivity = activityLogs.max(by: { $0.date > $1.date })
        var trackedToday = false
        if let latestActivity = latestActivity {
            trackedToday = Calendar.current.isDateInToday(latestActivity.date)
        }

        switch (activityLogs.count, trackedToday) {
        case (0, _) :
            return Color.red
        case (_, true) :
            return Color.green
        case (_, false) :
            return Color.blue
        }

    }

    func removeItems(at offsets: IndexSet) {
        storage.habits.remove(atOffsets: offsets)
    }



}

struct ContentView_Previews: PreviewProvider {
//    static let habits = [Habit(name: "Strength Exercise")]
//    static let activityLogs =


    static var previews: some View {
        ContentView()
    }
}
