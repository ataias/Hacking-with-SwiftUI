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
    @State private var wakeUp = Date()

    var body: some View {
        VStack {

            Form {
                Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                    Text("\(sleepAmount, specifier: "%g") hours")
                }
                DatePicker("Please enter a date", selection: $wakeUp)
            }
            DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
            .labelsHidden()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
