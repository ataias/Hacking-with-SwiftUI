//
//  ContentView.swift
//  WeSplit
//
//  Created by Ataias Pereira Reis on 08/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipPercentage = 2

    var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount * (tipSelection / 100)
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }

    let tipPercentages = [10, 15, 20, 25, 0]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(checkAmount)) { newValue in
                            let filtered = newValue.filter { "012345679.".contains($0) }
                            if filtered != newValue {
                                self.checkAmount = filtered
                            }
                        }

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0)")
                        }
                    }
                }

                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total Amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
