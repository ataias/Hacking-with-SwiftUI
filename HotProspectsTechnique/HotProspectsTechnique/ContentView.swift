//
//  ContentView.swift
//  HotProspectsTechnique
//
//  Created by Ataias Pereira Reis on 09/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

class User: ObservableObject {
    @Published var name = "Taylor Swift"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}

struct ContentView: View {
    let user = User()
    @State private var selectedTab = 0

    var body: some View {
        VStack {


            TabView(selection: $selectedTab) {
                VStack {
                    Text("Tab 1 - Show Only")
                    DisplayView()
                }
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "star")
                    Text("One")
                }
                .tag(0)

                VStack {
                    Text("Tab 2 - Edit View")
                    EditView()
                }
                .tabItem {
                    Image(systemName: "star.fill")
                    Text("Two")
                }
                .tag(1)

            }
        }
        .environmentObject(user)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
