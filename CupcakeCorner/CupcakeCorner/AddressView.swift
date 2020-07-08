//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 08/07/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order

    var body: some View {
            Form {
                Section {
                    TextField("Name", text: $order.name)
                    TextField("Street Address", text: $order.streetAddress)
                    TextField("City", text: $order.city)
                    TextField("Zip", text: $order.zip)
                }

                Section {
                    NavigationLink(destination: CheckoutView(order: order)) {
                        Text("Check out")
                    }
                    .disabled(!order.hasValidAddress)
                }
            }
            .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
