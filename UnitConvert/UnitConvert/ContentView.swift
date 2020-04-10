//
//  ContentView.swift
//  UnitConvert
//
//  Created by Ataias Pereira Reis on 10/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import Foundation

enum Unit : String {
    case Temperature
    case Length
    case Duration
    case Volume
}

struct ContentView: View {
    @State private var amount = "5.0"
    @State private var unitType = 0 // the index

    let unitTypes = [Unit.Temperature, .Length, .Duration, .Volume]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type of Unit", selection: $unitType) {
                        ForEach(0 ..< unitTypes.count) {
                            Text("\(self.unitTypes[$0].rawValue)")
                        }
                    }
                }
                Section(header: Text("From")) {
                    TextField("From", text: $amount)
                    .keyboardType(.decimalPad)
                }
                Section(header: Text("To")) {
                    TextField("To", text: $amount)
                    .keyboardType(.decimalPad)
                }
            }
            .navigationBarTitle("UnitConvert")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
