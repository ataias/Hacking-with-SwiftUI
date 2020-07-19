//
//  ContentView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 14/07/20.
//

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: CoreUser.entity(), sortDescriptors: []) var coreUsers: FetchedResults<CoreUser>

    @State private var errorMessage = ""
    @State private var users = [User]()

    var body: some View {
        NavigationView {
            UserListView(users: users, filter: nil)
                .navigationBarTitle("FriendFace")
                .onAppear(perform: getUserData)
        }
    }

    func addUser(user: User) {
        let coreUser = CoreUser(context: self.moc)
        coreUser.id = user.id
        let userData = try! User.encoder.encode(user)
        coreUser.data = String(decoding: userData, as: UTF8.self)
        try? self.moc.save()
    }

    func getUserData() {
        // Data already initialized
        if users.count > 0 {
            return
        }

        // Data not initialized, let's see if we can get it from core data
        if coreUsers.count > 0 {
            users = coreUsers.map({try! User.decoder.decode(User.self, from: $0.data!.data(using: .utf8)!)})
            return
        }

        // Fetch from web if not available in core data
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

            guard let users = try? User.decoder.decode([User].self, from: data) else {
                print("Response or decoder is wrong")
                return
            }

            print("Http Request happened")
            self.users = users

            users.forEach(addUser)

        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
