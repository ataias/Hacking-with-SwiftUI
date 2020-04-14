//
//  ContentView.swift
//  JackEnPoy
//
//  Created by Ataias Pereira Reis on 13/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct Score {
    var points: Int
    var totalGames: Int
}

enum GameResult {
    case Win
    case Lose
    case Draw
}

enum JackEnPoy: String {
    case Rock
    case Paper
    case Scissors

    func win(against: JackEnPoy) -> GameResult {
        switch (self, against) {
        case (.Rock, .Scissors), (.Scissors, .Paper), (.Paper, .Rock):
            return .Win
        default:
            return self == against ? .Draw : .Lose

        }
    }
}

struct AlertItem: Identifiable {
    var id = UUID()
    var title: Text
    var message: Text?
    var dismissButton: Alert.Button?
}

struct ContentView: View {
    let moves = [JackEnPoy.Rock, .Paper, .Scissors]

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var shouldWin = true
    @State private var score = Score(points: 0, totalGames: 0)
    @State private var scoreTitle = ""
    @State private var endOfGame = false
    @State private var gamesLeft = 10

    @State private var alertItem: AlertItem?

    var body: some View {
        VStack(spacing: 20) {
            Text("Jack En Poy")
                .titled()

            if shouldWin {
                Text("To win you should win")
            } else {
                Text("To win you should lose")
            }

            Spacer()
            VStack(spacing: 30) {
                ForEach(0 ..< moves.count) { n in
                    Button(action: {
                        self.update(forUserMove: self.moves[n])
                    }) {
                        MoveImage(image: self.moves[n].rawValue)
                    }
                    .alert(item: self.$alertItem) { alertItem in
                        Alert(title: alertItem.title, message: alertItem.message, dismissButton: alertItem.dismissButton)
                    }
                }
            }
            ScoreView(score)

        }
        .gradiented()
        .foregroundColor(.white)
    }

    func prepareNewGame() {
        self.correctAnswer = Int.random(in: 0...2)
        //        self.shouldWin = ...
    }

    func update(forUserMove userMove: JackEnPoy) {
        var points = score.points
        let totalGames = score.totalGames + 1

        let title = "You chose \(userMove) and the opponent chose \(moves[correctAnswer])"

        let gameResult = userMove.win(against: moves[correctAnswer])

        switch (gameResult, shouldWin) {
        case (.Win, shouldWin), (.Lose, !shouldWin):
            points += 1
            self.scoreTitle = "You win! " + title
        case (.Draw, _):
            self.scoreTitle = "Game was a draw!"
        default:
            self.scoreTitle = "You lose! " + title
        }

        self.score = Score(
            points: points,
            totalGames: totalGames
        )

        self.gamesLeft -= 1

        if self.gamesLeft > 0 {
            self.alertItem = AlertItem(
                title: Text(self.scoreTitle),
                message: Text("Points: \(self.score.points); Game# \(self.score.totalGames)"),
                dismissButton: .default(Text("Continue"), action: self.prepareNewGame)
            )
            print("Continue game")
        } else {
            self.alertItem = AlertItem(
                title: Text(self.scoreTitle),
                message: Text("Points: \(self.score.points); Game# \(self.score.totalGames)"),
                dismissButton:
                .destructive(Text("Reset"), action: {
                    self.score = Score(points: 0, totalGames: 0)
                    self.gamesLeft = 10
                    self.endOfGame = false
                    self.prepareNewGame()
                })
            )
            print("Reset game")
        }
    }
}

struct MoveImage: View {
    let image: String

    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Circle())
            .overlay(Circle()
                .stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle)
    }
}

struct ScoreView: View {
    let score: Score

    init(_ score: Score) {
        self.score = score
    }

    var body: some View {
        VStack {
            Text("Points: \(score.points)")
            Text("Game#: \(score.totalGames)")
        }
    }
}

struct BackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .blue]),
                startPoint: .top,
                endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            content
        }
    }
}

extension Bool {
    static func ^ (left: Bool, right: Bool) -> Bool {
        return left != right
    }
}

extension View {
    func titled() -> some View {
        self.modifier(Title())
    }

    func gradiented() -> some View {
        self.modifier(BackgroundModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
