//
//  Settings.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 19/08/20.
//

import SwiftUI

struct Settings: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {

        let isOn = Binding<Bool>(
            get: {
                UserDefaults.standard.bool(forKey: "Reinsert")
            },
            set: {
                UserDefaults.standard.setValue($0, forKey: "Reinsert")
            }
        )

        return (
            NavigationView {
                Form {
                    Toggle("Reinsert wrong answered cards at end of stack", isOn: isOn)
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button("Done", action: dismiss))
            }
            .navigationViewStyle(StackNavigationViewStyle())
        )
    }

    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
