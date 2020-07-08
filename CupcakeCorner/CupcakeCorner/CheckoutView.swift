//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 08/07/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    // TODO Find out what is happening below: I commented the resizing code but I saw no difference in the image. I also removed the GeometryReader and again saw no difference. Maybe I will see a difference if I run in another simulator? Another screen size.
                    Image("cupcakes")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: geo.size.width)

                    Text("Your total is $\(order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        // place the order
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
