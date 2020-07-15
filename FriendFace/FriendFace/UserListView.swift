//
//  UserListView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 15/07/20.
//

import SwiftUI

struct UserListView: View {

    let users: [User]

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserView(user: user)) {
                    HStack {
                        StatusView(isActive: user.isActive)
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.headline)
                            Text("\(user.friends.count) friends")
                        }
                    }
                }
            }
            .navigationBarTitle("FriendFace")
        }
    }
}

struct UserListView_Previews: PreviewProvider {

    static let users: [User] = Bundle.main.decode("friendface.json")

    static var previews: some View {
        UserListView(users: users)
    }
}
