//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 08/07/20.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var storage: Storage

    var body: some View {
            Form {
                Section {
                    TextField("Name", text: $storage.order.name)
                    TextField("Street Address", text: $storage.order.streetAddress)
                    TextField("City", text: $storage.order.city)
                    TextField("Zip", text: $storage.order.zip)
                }

                Section {
                    NavigationLink(destination: CheckoutView(storage: storage)) {
                        Text("Check out")
                    }
                    .disabled(!storage.order.hasValidAddress)
                }
            }
            .navigationBarTitle("Delivery Details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(storage: Storage())
    }
}
