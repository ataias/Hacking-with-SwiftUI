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
    @State private var animationAmount = 0.0
    @State private var answered: Optional<Int> = .none

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

    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]

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
                        withAnimation(.default) {
                            self.answered = .some(number)
                            self.flagTapped()
                        }
                    }) {
                        FlagImage(image: self.countries[number])
                            .accessibility(label: Text(self.labels[self.countries[number], default: "Unknown flag"]))
                            .rotation3DEffect(
                                .degrees(self.animationAmount),
                                axis: (x: 0, y: 1, z: 0),
                                perspective: 0)
                            .animation(self.animateCorrect(answer: number))
                            .opacity(self.getCardOpacity(answer: number))
                            .offset(self.getOffset(answer: number))
                            .animation(self.answered != .none ? .linear : nil)

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

    func animateCorrect(answer number: Int) -> Animation? {
        return isCorrect(answer: number) ? .default : nil
    }

    func animateWrong(answer number: Int) -> Animation? {
        return isWrong(answer: number) ? .default : nil
    }

    func getOffset(answer number: Int) -> CGSize {
        if self.answered == .none {
            return CGSize.zero
        }

        return self.correctAnswer != number
            ? CGSize.init(width: 500, height: 0)
            : CGSize.zero
    }

    func getCardOpacity(answer number: Int) -> Double {
        // cards are in normal opacity in an unanswered state
        if self.answered == .none {
            return 1.0
        }

        return self.correctAnswer == number ? 1.0 : 0.25
    }

    func isCorrect(answer number: Int) -> Bool {
        return self.answered != .none && self.correctAnswer == number
    }

    func isWrong(answer number: Int) -> Bool {
        return self.answered != .none && self.correctAnswer == number
    }

    func flagTapped() {
        guard let number = self.answered else {
            return
        }
        var correct = score.correct;
        let isCorrect = number == correctAnswer
        if isCorrect {
            scoreTitle = "Correct!"
            correct += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true

        score = Score(count: score.count + 1, correct: correct)

        animationAmount = isCorrect ? 360 : 0

    }

    func askQuestion() {
        answered = .none
        animationAmount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }

    struct FlagImage: View {
        let image: String

        var body: some View {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .overlay(Capsule()
                    .stroke(Color.black, lineWidth: 1))
                .shadow(color: .black, radius: 2)
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
