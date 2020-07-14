//
//  UserView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 14/07/20.
//

import SwiftUI

struct UserView: View {
    let user: User

    var body: some View {
        VStack(alignment: .leading) {
            Section(header: Text(user.name).font(.title)) {
                Text(user.isActive ? "Active" : "Inactive") // TODO change by circle with color
                // TODO for the next fields and any missing ones, you could have a "userdetailitem" view to show it. It could show them aligned, with a different style for the header and another for the value
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Tags: \(user.tags.joined(separator: ", "))")
                Text("Age: \(user.age)")
                    .padding(.bottom)

            }

            Section(header: Text("About").font(.title)) {
                Text(user.about)
            }

            Spacer()

            // TODO Add friends list (will need the user data list)
            // About the navigation link, how to handle it? I could add one to go to their friends, but would this go indefinitely? or do I limit it somehow?
        }
        .padding(.all, 20)
    }
}

struct UserView_Previews: PreviewProvider {
    static let user = User(id: UUID(), isActive: true, name: "Ataias Pereira Reis", age: 26, company: "XYZ Corporation", email: "ataias@ataias.com", address: "Casa da Esquina 123", about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.", registered: Date(), tags: ["programmer", "husband"], friends: [])
    static var previews: some View {
        UserView(user: user)
    }
}
