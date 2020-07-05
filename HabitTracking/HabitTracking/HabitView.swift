//
//  HabitView.swift
//  HabitTracking
//
//  Created by Ataias Pereira Reis on 30/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct HabitView: View {
    let habit: Habit
    let activityLogs: [ActivityLog]
    @ObservedObject var storage: Storage

    @State private var showingAddActivityLog = false

    init(habit: Habit, storage: Storage) {
        self.habit = habit
        self.activityLogs = storage.activityLogs.filter { $0.habitId == habit.id }
        self.storage = storage
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    // TODO Consider adding images to habits, or maybe special codes to ease finding them

                    HStack {
                        Text("Habit")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                        Text(self.habit.name)
                            .bold()
                    }
                    .padding()


                    HStack {
                        Text("Log")
                            .font(.largeTitle)
                            .bold()
                        Spacer()
                    }
                    .padding()

                    Text("You completed this activity \(activityLogs.count) times")
                        .padding()

                    if self.activityLogs.count == 0 {
                        Text("No Logs Available")
                    } else {
                        ForEach(activityLogs) { activityLog in
                            HStack {
                                Text("DATE").bold()
                                Text("\(activityLog.formattedDate)")
                                Spacer()
                                Text("COMPLETED").bold()
                                Text(activityLog.completed ? "YES" : "NO")
                            }
                            .padding([.all], 10)

                        }
                    }
                }



            }
        }
        .navigationBarTitle(Text(habit.name), displayMode: .inline)
        .navigationBarItems(
            //            leading: EditButton(),
            trailing: Button(action: {
                self.showingAddActivityLog = true
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $showingAddActivityLog) {
            AddActivityLogView(habit: self.habit, storage: self.storage)
        }

    }

}

struct HabitView_Previews: PreviewProvider {
    static var storage = Storage(completed: true)

    static var previews: some View {
        HabitView(habit: storage.habits[0], storage: storage)
    }
}
