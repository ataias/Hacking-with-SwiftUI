//
//  UserView.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 14/07/20.
//

import SwiftUI

struct StatusView: View {
    let color: Color

    init(isActive: Bool) {
        color = isActive ? Color.green : Color.gray
    }
    var body: some View {
        Circle()
            .foregroundColor(color)
            .frame(width: 20, height: 20, alignment: .center)
    }
}

struct StaticFormItem: View {
    let title: String
    let data: String

    var body: some View {
        HStack(alignment: .top) {
            Text("\(title): ").bold()
            Text(data)
        }
        .padding(.bottom, 8)
    }
}

struct UserInfo: View {
    let user: User

    var body: some View {
        Section(header: Text("Info").font(.title)) {
            VStack(alignment: .leading) {

                StaticFormItem(title: "Company", data: user.company)
                StaticFormItem(title: "Email", data: user.email)
                StaticFormItem(title: "Address", data: user.address)
                StaticFormItem(title: "Tags", data: user.tags.joined(separator: ", "))
                StaticFormItem(title: "Age", data: "\(user.age)")
                    .padding(.bottom)
            }
            .padding(8)
            .card()
        }

        .padding(.bottom, 10)
    }
}

extension View {
    func card() -> some View {
        self.modifier(CardLike())
    }
}


struct CardLike: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 3)
            )
    }
}


struct UserView: View {
    let user: User
    let users: [User]

    init(user: User, users: [User]) {
        self.user = user
        self.users = users
    }

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading) {
                Section(header: HStack {
                    Text(user.name).font(.title)
                    Spacer()
                    StatusView(isActive: user.isActive)
                }) {
                    UserInfo(user: user)
                }

                Section(header: Text("About").font(.title)) {
                    Text(user.about)
                        .padding(8)
                        .card()
                }

                Section(header: Text("Friends").font(.title)) {
                    UserListView(users: users, filter: user.friends)
                        .frame(minHeight: 500)
                }
                .padding(.top, 10)


                Spacer()
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static let users: [User] = Bundle.main.decode("friendface.json")

    static var previews: some View {
        UserView(user: users[0], users: users)
    }
}
