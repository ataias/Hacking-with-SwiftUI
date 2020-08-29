//
//  SettingsView.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("sides") var numberOfSides: Int = 10

    var body: some View {
        Form {
            Section(header: Text("Number of sides")) {
            Picker("Number of sides", selection: $numberOfSides) {
                ForEach(DiceTypes.sides, id: \.self) { sides in
                    Text("\(sides)")
                }
            }
            // FIXME? For whatever reason the default picker style was not working on the simulator when I tried
            .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct DiceTypes {
    static let sides = [
        4,
        6,
        8,
        10,
        12,
        20,
        24,
        30,
        48,
        60,
        120
    ]
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
