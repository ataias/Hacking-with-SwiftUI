//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 15/08/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var isActive = true
    @State private var showingEditScreen = false
    @State private var showingSettingsScreen = false
    @State private var reinsertWrongCards = false


    /// This list of ordered cards was created to simplify code inside the foreach.
    /// First, ForEach had a bug (or at least in this app it became a bug) that removing an item from the end of the list and reinserting it at the beginning didn't trigger a re-render of the card. The data was present, but the rendering was wrong then.
    /// One hacky solution to it was updating the card id (UUID) before re-inserting. However, using a "compositeKey" you avoid this hack by having an id that depends on the position and triggering the re-render.
    private var orderedCards: [(index: Int, card: Card, compositeId: String)] {
        cards.enumerated().map { index, card in (index: index, card: card, compositeId: "\(index)\(card.id)") }
    }

    var body: some View {
        ZStack {
            Image(decorative: "background") // this is to improve VoiceOver experience
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 5.0)
                    .background(Capsule().fill(Color.black).opacity(0.75))


                if timeRemaining > 0 {
                    ZStack {
                        ForEach(orderedCards, id: \.compositeId) { (index, card, _) in
                            CardView(card: card) { answerState in
                                remove(card: card, answerState: answerState)
                            }
                            .stacked(at: index, in: cards.count)
                            .allowsHitTesting(index == cards.count - 1)
                            .accessibility(hidden: index < cards.count - 1) // don't read all cards in accessibility mode, just top one
                        }
                    }
                } else {
                    Button(action: resetCards) {
                        VStack {
                            Text("Time's Up!")
                            Text("Start Again")
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                    .padding()
                }

                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }

            }
            .sheet(isPresented: $showingSettingsScreen, onDismiss: resetCards, content: {
                Settings()
            })

            VStack {
                HStack {

                    Button(action: {
                        showingSettingsScreen = true
                    }) {
                        Image(systemName: "gear")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Button(action: {
                        showingEditScreen = true
                    }) {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                    }
                }

                Spacer()
            }
            .sheet(isPresented: $showingEditScreen, onDismiss: resetCards, content: {
                EditCards()
            })

            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()


            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                            withAnimation {
                                remove(card: cards[cards.count - 1], answerState: CardView.AnswerState.wrong)
                            }
                        }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect"))

                        Spacer()
                        Button(action: {
                            withAnimation {
                                remove(card: cards[cards.count - 1], answerState: CardView.AnswerState.correct)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer, perform: { time in
            guard isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
            isActive = false
        })
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            isActive = !cards.isEmpty
        }
        .onAppear(perform: resetCards)
    }

    func remove(card: Card?, answerState: CardView.AnswerState) {
        guard let card = card else { return }
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }

        let removed = cards.remove(at: index)
        if reinsertWrongCards && answerState == CardView.AnswerState.wrong {
            cards.insert(removed, at: 0)
        }
        isActive = !cards.isEmpty
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        reinsertWrongCards = UserDefaults.standard.bool(forKey: "Reinsert")
        loadData()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(.fixed(width: 600, height: 550))
                .padding()
        }
    }
}
