//
//  ContentView.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 25/08/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var pendingRolls = 0
    @State private var currentNumber = 5
    @State private var sides = 10

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                VStack {
                    Text("Tab 1 - Show Only")
                    DiceView(number: currentNumber)
                    Button(action: start) {
                        Text("Play")
                    }
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
            .onReceive(timer, perform: roll)
        }

    }

    func start() {
        pendingRolls = 5
    }

    func roll(_ date: Date) {
        guard pendingRolls > 0 else { return }
        var next = Int.random(in: 1...sides)
        while next == currentNumber {
            next = Int.random(in: 1...sides)
        }
        withAnimation {
            currentNumber = next
        }
        pendingRolls -= 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
