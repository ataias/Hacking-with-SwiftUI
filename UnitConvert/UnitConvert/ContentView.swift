//
//  ContentView.swift
//  UnitConvert
//
//  Created by Ataias Pereira Reis on 10/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

extension UnitDuration {
    open class var days: UnitDuration {
        let SECONDS_IN_DAY = Double(24 * 60 * 60)
        return UnitDuration(symbol: "d", converter: UnitConverterLinear(coefficient: SECONDS_IN_DAY))
    }
}

extension String {
    func sanitizeDecimal() -> String {
        var value = self
        var parsed = value.filter { "0123456789.".contains($0) }
        let dots = (parsed.filter {$0 == "."}).count

        if parsed != self {
            value = parsed
        }

        if dots > 1 {
            parsed.remove(at: parsed.lastIndex(of: ".")!)
            value = parsed
        }

        return value
    }
}

enum Unit : String {
    case Temperature
    case Length
    case Duration
    case Volume

    static let temperatureUnits = [
        UnitTemperature.celsius,
        .fahrenheit,
        .kelvin
    ]
    static let lengthUnits = [
        UnitLength.meters,
        .kilometers,
        .centimeters,
        .feet,
        .yards,
        .miles
    ]
    static let durationUnits = [
        UnitDuration.seconds,
        .minutes,
        .hours,
        .days,
    ]
    static let volumeUnits = [
        UnitVolume.milliliters,
        .liters,
        .cups,
        .pints,
        .gallons
    ]

    var subUnits: [Dimension] {
        switch self {
        case .Temperature:
            return Unit.temperatureUnits
        case .Length:
            return Unit.lengthUnits
        case .Duration:
            return Unit.durationUnits
        case .Volume:
            return Unit.volumeUnits
        }
    }

    static let types = [Unit.Temperature, .Length, .Duration, .Volume]
}

struct ContentView: View {
    @State private var amount = "5.0"
    @State private var fromUnit = 0
    @State private var toUnit = 1
    @State private var unitType = 0

    var subUnits: [Dimension] {
        return Unit.types[unitType].subUnits
    }

    var convertedValue: Double {
        let number = Double(amount) ?? 0
        return Measurement(
            value: number,
            unit: subUnits[fromUnit]
        ).converted(to: subUnits[toUnit])
            .value
    }

    var body: some View {

        let unitTypeBinding = Binding<Int>(
            get: { self.unitType },
            set: {
                self.unitType = $0;
                self.fromUnit = 0;
                self.toUnit = 1;
        }
        )

        return NavigationView {
            Form {
                Section {
                    Picker("Type of Unit", selection: unitTypeBinding) {
                        ForEach(0 ..< Unit.types.count) {
                            Text("\(Unit.types[$0].rawValue)")
                        }
                    }
                }
                Section(header: Text("Value")) {
                    TextField("Value", text: $amount)
                        .keyboardType(.decimalPad)
                        .onReceive(Just(amount)) { newValue in
                            self.amount = newValue.sanitizeDecimal()
                    }
                }
                Section(header: Text("Select from and to")) {

                    // Be mindful of id(:identifier:); it avoids the picker not changing after subUnits count does
                    // https://stackoverflow.com/a/58359139/2304697
                    Picker("From", selection: $fromUnit) {
                        ForEach(0 ..< subUnits.count) {
                            Text("\(self.subUnits[$0].symbol)")
                        }
                    }
                    .id(Unit.types[self.unitType])

                    Picker("To", selection: $toUnit) {
                        ForEach(0 ..< subUnits.count) {
                            Text("\(self.subUnits[$0].symbol)")
                        }
                    }
                    .id(Unit.types[self.unitType])
                }

                Section(header: Text("Converted Value")) {
                    Text("\(convertedValue, specifier: "%g")\(subUnits[toUnit].symbol)")
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
