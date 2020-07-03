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

    init(habit: Habit, activityLogs: [ActivityLog]) {
        self.habit = habit
        self.activityLogs = activityLogs.filter { $0.habitId == habit.id }

    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    // TODO Consider adding images to habits, or maybe special codes to ease finding them
//                    Image(self.astronaut.id)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geometry.size.width)

                    Text("Habit")
                        .font(.largeTitle)
                        .padding()

                    Text(self.habit.name)
                            .padding()
                    }

                    Text("Log")
                        .font(.largeTitle)

                if self.activityLogs.count == 0 {
                    Text("No Logs Available")
                } else {
                    ForEach(self.activityLogs) { activityLog in
                        Text("\(activityLog.formattedDate)")
                    }
                }

            }
        }
        .navigationBarTitle(Text(habit.name), displayMode: .inline)

    }

}

struct HabitView_Previews: PreviewProvider {
    static let habit = Habit(name: "Strength Exercise", type: "Personal", notes: "")
    static let activityLogs = [
        ActivityLog(habitId: habit.id, date: Date(), notes: "Nothing really")
    ]

    static var previews: some View {
        HabitView(habit: habit, activityLogs: activityLogs)
    }
}
