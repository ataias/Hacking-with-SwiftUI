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

        // DONE If results have data, just set users based on that
        if coreUsers.count > 0 {
            var tempUsers = [User]()
            for coreUser in coreUsers {
                let jsonStr: Data = coreUser.data!.data(using: .utf8)!
                let tempUser = try! User.decoder.decode(User.self, from: jsonStr)
                tempUsers.append(tempUser)
            }
            users = tempUsers
            return
        }

        // TODO If results don't have data, do the request and then update core data AND users based on it
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
