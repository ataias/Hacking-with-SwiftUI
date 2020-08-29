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
    @State private var isShowingSettingsView = false
    @AppStorage("sides") var numberOfSides = 10

    @FetchRequest(entity: Game.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Game.date, ascending: true),
    ]) var games: FetchedResults<Game>
    @Environment(\.managedObjectContext) var moc

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        NavigationView {
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
                        List {
                            ForEach(games.scores) { game in
                                ScoreView(score: game)
                            }
                        }
                    }
                    .tabItem {
                        Image(systemName: "gamecontroller")
                        Text("Score")
                    }
                    .tag(1)
                }
                .sheet(isPresented: $isShowingSettingsView, content: {
                    SettingsView()
                })
                .onReceive(timer, perform: roll)
            }
            .navigationBarItems(leading: Button(action: {
                isShowingSettingsView = true
            }, label: {
                Image(systemName: "gear")
            }))
        }

    }

    func start() {
        pendingRolls = 5
    }

    func roll(_ date: Date) {
        guard pendingRolls > 0 else { return }
        var next = Int.random(in: 1...numberOfSides)
        while next == currentNumber {
            next = Int.random(in: 1...numberOfSides)
        }
        withAnimation {
            currentNumber = next
        }
        pendingRolls -= 1

        if pendingRolls == 0 {
            let game = Game(context: self.moc)
            game.id = UUID()
            game.date = Date()

            let diceRoll = DiceRoll(context: self.moc)
            diceRoll.game = game
            diceRoll.sequence = 1
            diceRoll.value = Int64(currentNumber)
            diceRoll.maxValue = Int64(numberOfSides)

            try? self.moc.save()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
