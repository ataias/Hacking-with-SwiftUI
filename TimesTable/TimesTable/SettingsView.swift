//
//  SettingsView.swift
//  TimesTable
//
//  Created by Ataias Pereira Reis on 14/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @State private var currentChallengeIndex = 0
    @State private var isGameRunning: Bool = false
    @State private var selectedTables: [Bool] = (0..<maxTimesTable).map { _ in true }

    var body: some View {
        VStack {
            Section {
                Text("What time tables would you like to play with?")
                GridStack(rows: 3, columns: 4) { row, col in
                    Button(action: {
                        self.toggleTableForGame(row, col)
                    }) {
                        Image(systemName: "\(self.timesTableForGridItem(row, col)).square")
                            .padding()
                            .foregroundColor(self.getButtonColor(row, col))
                    }
                }
                .font(.largeTitle)
                HStack {
                    Button(action: selectAllTables) {
                        Text("ALL")
                            .padding([.all], 6)
                            .foregroundColor(allSelected ? .gray : .black)
                    }


                    Button(action: deselectAllTables) {
                        Text("NOTHING")
                            .padding([.all], 6)
                            .foregroundColor(noneSelected ? .black : .gray)
                    }

                }
            }
            Spacer()
            Section {
                NavigationLink(
                    destination: GameView(
                        challenges: generate(),
                        currentChallengeIndex: $currentChallengeIndex,
                        isGameRunning: $isGameRunning),
                    isActive: $isGameRunning) {
                        Text("START")
                }
                .disabled(!noneSelected)
            }
            .padding()
        }
        .onAppear(perform: {self.currentChallengeIndex = 0})

    }

    func toggleTableForGame(_ row: Int, _ col: Int) {
        selectedTables[timesTableForGridItem(row, col) - 1].toggle()
    }

    func timesTableForGridItem(_ row: Int, _ col: Int) -> Int {
        return row * 4 + col + 1
    }

    func getButtonColor(_ row: Int, _ col: Int) -> Color {
        return selectedTables[timesTableForGridItem(row, col) - 1] ? .black : .gray
    }

    func selectAllTables() {
        for i in 0..<12 {
            selectedTables[i] = true
        }
    }

    var allSelected: Bool {
        selectedTables.reduce(true) { (acc, el) in
            return acc && el
        }
    }

    func deselectAllTables() {
        for i in 0..<12 {
            selectedTables[i] = false
        }
    }

    var noneSelected: Bool {
        selectedTables.reduce(false) { (acc, el) in
            return acc || el
        }
    }

    func generate() -> [MathChallenge] {
        var challenges: [MathChallenge] = []
        for i in 0..<maxTimesTable {
            if selectedTables[i] {
                for j in 1...maxTimesTable {
                    challenges.append(MathChallenge(left: i + 1, right: j, operation: "x", answer: (i + 1) * j))
                }
            }
        }
        return challenges.shuffled()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
