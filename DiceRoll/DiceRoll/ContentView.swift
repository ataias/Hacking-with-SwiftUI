//
//  ContentView.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 25/08/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Tab 1 - Show Only")
                    DiceView(number: 5)
                }
                .onTapGesture {
                    self.selectedTab = 1
                }
                .tabItem {
                    Image(systemName: "play")
                    Text("Play")
                }
                .tag(0)

                VStack {
                    Text("Tab 2 - Edit View")
                }
                .tabItem {
                    Image(systemName: "gamecontroller")
                    Text("Score")
                }
                .tag(1)



            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
