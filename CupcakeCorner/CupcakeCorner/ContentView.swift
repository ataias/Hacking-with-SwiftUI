//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 07/07/20.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }

                    Stepper(value: $order.quantity, in: 3...20) {
                        Text("Number of cupcakes: \(order.quantity)")
                    }
                }

                Section {
                    // This animation makes the "if" below animate and show smoothly
                    Toggle(isOn: $order.specialRequestEnabled.animation(), label: {
                        Text("Any special requests?")
                    })

                    if order.specialRequestEnabled {

                        Toggle(isOn: $order.extraFrosting) {
                            Text("Add extra frosting")
                        }

                        Toggle(isOn: $order.addSprinkles, label: {
                            Text("Add extra sprinkles")
                        })
                    }
                }

                Section {
                    NavigationLink(
                        destination: AddressView(order: order),
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
