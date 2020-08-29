//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct SecondaryView: View {
    @State private var selectedUser: User?
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack {
            Text("Secondary")
            Text("Hello, World!")
                .onTapGesture {
                    self.selectedUser = User()
                }
                .alert(item: $selectedUser) { user in
                    Alert(title: Text(user.id))
                }

            Group {
                if layoutVertically {
                    VStack {
                        UserView()
                    }
                } else {
                    HStack {
                        UserView()
                    }
                }
            }
            .onTapGesture {
                self.layoutVertically.toggle()
            }
            Spacer()
            Group {
                if sizeClass == .compact {
                    VStack(content: UserView.init)
                } else {
                    HStack(content: UserView.init)
                }
            }


        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: SecondaryView()) {
                Text("Hello, World!")
            }
            .navigationBarTitle("Primary")

            SecondaryView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
