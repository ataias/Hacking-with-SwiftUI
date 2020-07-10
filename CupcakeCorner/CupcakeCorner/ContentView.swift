//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 07/07/20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var storage = Storage()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $storage.order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $storage.order.quantity, in: 3...20) {
                        Text("Number of cupcakes: \(storage.order.quantity)")
                    }
                }

                Section {
                    // This animation makes the "if" below animate and show smoothly
                    Toggle(isOn: $storage.order.specialRequestEnabled.animation(), label: {
                        Text("Any special requests?")
                    })

                    if storage.order.specialRequestEnabled {

                        Toggle(isOn: $storage.order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $storage.order.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                }

                Section {
                    NavigationLink(
                        destination: AddressView(storage: storage),
                        label: {
                            Text("Delivery details")
                        })
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
