//
//  GameView.swift
//  TimesTable
//
//  Created by Ataias Pereira Reis on 14/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct GameView: View {
    let challenges: [MathChallenge]

    @Binding var currentChallengeIndex: Int
    @Binding var isGameRunning: Bool
    @State private var answerOptions: [AnswerOption] = []
    @State private var showingScore = false
    @State private var score: Score?
    @State private var timer: Timer?

    var challenge: MathChallenge {
        return challenges[currentChallengeIndex]
    }

    var body: some View {
        VStack {
            if score == nil {
                Text("Loading")
            } else if score!.totalSoFar == score!.count {
                Text("")
            } else {
                Text("\(challenge.left) \(challenge.operation) \(challenge.right) =")
                    .font(.largeTitle)
                    .padding()
                GridStack(rows: totalGameRows, columns: totalGameColumns) { row, col in
                    Button(action: {
                        self.answer(self.getAnswerIndex(row, col))
                    }) {
                        Text("\(self.answerOptions[self.getAnswerIndex(row, col)].value)")
                            .frame(width: 60, height: 40)
                            .animation(nil)
                            .border(self.answerOptions[self.getAnswerIndex(row, col)].color, width: 2)
                            .foregroundColor(self.answerOptions[self.getAnswerIndex(row, col)].color)
                            .animation(.default)
                            .padding()
                            .font(.largeTitle)
                    }
                }
                Spacer()
                Section(header: Text("Running Score").fontWeight(.bold)) {
                    Text("\(score!.totalSoFar) answered")
                    Text("\(score!.correct) correct")
                    Text("\(score!.wrong) wrong")
                    Text("\(score!.leftGames) games left to go")
                }
            }
        }
        .onAppear(perform: startGame)
        .alert(isPresented: self.$showingScore) {
            Alert(
                title: Text("You finished your practice!"),
                message: Text(
                    "Your score is \(self.score!.toString())"
                ),
                dismissButton: .default(Text("OK")) {
                    self.isGameRunning = false
                })
        }
    }

    func startGame() {
        answerOptions = getAnswerOptions(challenge: challenges[currentChallengeIndex])

        showingScore = false
        if score == nil {
            score = Score(count: challenges.count, totalSoFar: 0, correct: 0)
        }
    }

    func answer(_ answerIndex: Int) {
        let chosenAnswer = answerOptions[answerIndex]
        // TODO Save the statistics in a variable, so that we can show at the end how many were right for each multiplication table

        score!.totalSoFar += 1
        if chosenAnswer.correct {
            score!.correct += 1
            answerOptions[answerIndex].color = Color.green
        } else {
            answerOptions[answerIndex].color = Color.red
        }

        // Leave some time for the animation
        timer = Timer.scheduledTimer(withTimeInterval: 1.6, repeats: false) { _ in
            withAnimation(.easeInOut(duration: 1)) {
                // Prepare for new game
                self.answerOptions = []
                self.currentChallengeIndex += 1
                if self.currentChallengeIndex < self.challenges.count {
                    self.startGame()
                } else {
                    self.showingScore = true
                }
            }
            self.timer?.invalidate()
        }
    }

    func getAnswerIndex(_ row: Int, _ col: Int) -> Int {
        return row * totalGameColumns + col
    }

    func getAnswerOptions(challenge: MathChallenge) -> [AnswerOption] {
        guard totalGameAnswers >= 2 else {
            fatalError("The total of answer options should be >= 2; value passed is \(totalGameAnswers)")
        }
        let answerOptions = [AnswerOption(value: challenge.answer, correct: true, color: Color.blue)] + challenges.map({ $0.answer }).filter({$0 != challenge.answer}).map({AnswerOption(value: $0, correct: false, color: Color.blue)}).prefix(totalGameAnswers - 1)
        return answerOptions.shuffled()

    }

}

let challenges: [MathChallenge] = [
    MathChallenge(left: 1, right: 1, operation: "x", answer: 1),
    MathChallenge(left: 1, right: 2, operation: "x", answer: 2),
    MathChallenge(left: 1, right: 3, operation: "x", answer: 3),
    MathChallenge(left: 1, right: 4, operation: "x", answer: 4),
    MathChallenge(left: 1, right: 5, operation: "x", answer: 5),
    MathChallenge(left: 1, right: 6, operation: "x", answer: 6),
]

struct GameView_Previews: PreviewProvider {

    static var previews: some View {
        GameView(challenges: challenges, currentChallengeIndex: .constant(0), isGameRunning: .constant(false))
    }
}
