//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ataias Pereira Reis on 12/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct Score {
    var count: Int
    var correct: Int

    func toString() -> String {
        return "\(correct)/\(count)"
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = Score.init(count: 0, correct: 0)

    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
        ].shuffled()

    @State private var correctAnswer = Int.random(in: 0...2)

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.blue, .black]),
                startPoint: .top,
                endPoint: .bottom
            )
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .fixedSize(horizontal: true, vertical: false)
                }

                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                .stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)

                    }
                    .alert(isPresented: self.$showingScore) {
                        Alert(
                            title: Text(self.scoreTitle),
                            message: Text(
                                "Your score is \(self.score.toString())"
                            ),
                            dismissButton: .default(Text("Continue")) {
                                self.askQuestion()
                            })
                    }
                }
                Spacer()

                Section {
                    Text("Score: \(self.score.toString())")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                }
            }
        }
    }

    func flagTapped(_ number: Int) {
        var correct = score.correct;
        if number == correctAnswer {
            scoreTitle = "Correct!"
            correct += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true

        score = Score(count: score.count + 1, correct: correct)
    }

    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
