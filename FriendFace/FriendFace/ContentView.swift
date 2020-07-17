//
//  ContentView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 14/07/20.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc

    @State private var errorMessage = ""
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            UserListView(users: users, filter: nil)
                .navigationBarTitle("FriendFace")
                .onAppear(perform: getUserData)
        }
    }

    func getUserData() {
        // Prepare a URLRequest to send our encoded data as JSON.
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)

        // Run that request and process the response.
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error")")
                errorMessage = "\(error?.localizedDescription ?? "Unknown error")"
                // TODO actually add the alert to the UI
                // showingAlert = true
                return
            }

            let decoder = JSONDecoder()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            decoder.dateDecodingStrategy = .formatted(formatter)

            guard let users = try? decoder.decode([User].self, from: data) else {
                print("Response or decoder is wrong")
                return
            }

            self.users = users

        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
