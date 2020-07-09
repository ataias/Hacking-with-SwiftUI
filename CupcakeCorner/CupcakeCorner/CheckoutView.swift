//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 08/07/20.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

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
                        self.placeOrder()
                    }
                    .padding()
                }
                .alert(isPresented: $showingConfirmation) {
                    Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }

    func placeOrder() {
        // DONE 1. Convert our current order object into some JSON data that can be sent.
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Encoding failed.")
            return
        }

        // DONE 2. Prepare a URLRequest to send our encoded data as JSON.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded


        // DONE 3. Run that request and process the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            guard let serverOrder = try? JSONDecoder().decode(Order.self, from: data) else {
                print("Response or decoder is wrong")
                return
            }

            confirmationMessage = "Your order for \(serverOrder.quantity)x \(Order.types[serverOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
