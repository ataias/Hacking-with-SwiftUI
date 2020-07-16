//
//  UserListView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 15/07/20.
//

import SwiftUI

struct UserListView: View {

    let users: [User]
    let showOnly: [User]

    init(users: [User], filter: [Friend]?) {
        self.users = users
        if let filter = filter {
            self.showOnly = filter.compactMap { friend in users.first(where: { friend.id == $0.id }) }
        } else {
            self.showOnly = users
        }
    }

    var body: some View {
            List(showOnly) { user in
                NavigationLink(destination: UserView(user: user, users: users)) {
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
    }
}

struct UserListView_Previews: PreviewProvider {

    static let users: [User] = Bundle.main.decode("friendface.json")

    static var previews: some View {
        UserListView(users: users, filter: nil)
    }
}
