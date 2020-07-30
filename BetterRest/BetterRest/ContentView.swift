//
//  ContentView.swift
//  BetterRest
//
//  Created by Ataias Pereira Reis on 18/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmountIndex = 0

    var coffeeAmount: Double {
        return Double(coffeeAmountIndex + 1)
    }

    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    let model = SleepCalculator()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                        Text("\(sleepAmount, specifier: "%g") hours")
                            .accessibility(label: Text("\(sleepAmountAccessibility) of desired sleep time"))
                    }
                }
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)

                    Picker("", selection: $coffeeAmountIndex) {
                        ForEach(1 ..< 20) { n in
                            if n == 1 {
                                Text("1 cup")
                            } else {
                                Text("\(n) cups")
                            }
                        }
                    }
                }

                BedTime(bedTime: bedTime)
            }
            .navigationBarTitle("BetterRest")
        }
    }

    var sleepAmountAccessibility: String {
        let hours: Int = Int(sleepAmount) % 24
        let hoursSuffix = hours == 1 ? "hour" : "hours"
        let minutes: Int = Int(sleepAmount * 60) % 60
        let minutesSuffix = minutes == 1 ? "minute" : "minutes"

        if minutes == 0 {
            return "\(hours) \(hoursSuffix)"
        }
        return "\(hours) \(hoursSuffix) \(minutes) \(minutesSuffix)"
    }

    var bedTime: String? {
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60

        do {
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )

            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            return .none
        }
    }

    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct BedTime: View {
    let bedTime: String?

    var body: some View {
        Section {
            Text("Your ideal bedtime is...")
                .font(.headline)
            Text(bedTime ?? "Sorry, there was a problem calculating your bedtime.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
