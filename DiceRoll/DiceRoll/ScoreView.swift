//
//  ScoreView.swift
//  DiceRoll
//
//  Created by Ataias Pereira Reis on 27/08/20.
//

import SwiftUI

struct ScoreView: View {
    let score: Score

    var scoreSum: Int {
        score.rolls.reduce(0) { acc, roll in
            acc + roll.value
        }
    }

    var maxPossibleScore: Int {
        score.rolls.reduce(0) { acc, roll in
            acc + roll.maxValue
        }
    }

    var body: some View {
        VStack {
            DisclosureGroup(
                content: {
                    VStack {
                        HStack {
                            Text("Date: ").bold()
                            Text("\(score.formattedDate)")
                            Spacer()
                        }


                        HStack {
                            VStack {
                                ForEach(score.rolls) { roll in
                                    HStack {
                                        Text("Play \(roll.id): ").bold()
                                        Text("\(roll.value)")
                                    }
                                }
                            }
                            VStack {
                                ForEach(score.rolls) { roll in
                                    HStack {
                                        Text("#Dice Faces: ").bold()
                                        if roll.maxValue != 0 {
                                            Text("\(roll.maxValue)")
                                        } else {
                                            Text("N/A")
                                        }
                                    }
                                }
                            }
                            Spacer()
                        }

                        HStack {
                            Text("Total Score: ").bold()
                            Text("\(scoreSum)/\(maxPossibleScore)")
                            Spacer()
                        }
                    }

                },
                label: { HStack {
                    Text("Game \(score.id)").bold()
                    Spacer()
                    Text("\(scoreSum)/\(maxPossibleScore)")
                } }
            )
            .padding()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static let score: Score = {
        let rolls = [
            Roll(id: 1, value: 3, maxValue: 6),
            Roll(id: 2, value: 5, maxValue: 6),
            Roll(id: 3, value: 2, maxValue: 6),
            Roll(id: 4, value: 3, maxValue: 0),
        ]

        return Score(id: 1, date: Date(), rolls: rolls)
    }()

    static var previews: some View {
        Group {
            ScoreView(score: score)
                .previewLayout(PreviewLayout.sizeThatFits)

        }
    }
}
