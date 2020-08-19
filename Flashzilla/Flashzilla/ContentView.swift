//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 15/08/20.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @State private var cards = [Card](repeating: Card.example, count: 10)
    @State private var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var isActive = true

    var body: some View {
        ZStack {
            Image("background")
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

                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            removeCard(at: index)
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1)
                        .accessibility(hidden: index < cards.count - 1) // don't read all cards in accessibility mode, just top one
                    }
                }
                .allowsHitTesting(timeRemaining > 0)

                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }

            }


            if differentiateWithoutColor {
                VStack {
                    Spacer()
                    HStack {
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
                        Spacer()
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .clipShape(Circle())
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
    }

    func removeCard(at index: Int) {
        cards.remove(at: index)
        isActive = !cards.isEmpty
    }

    func resetCards() {
        cards = [Card](repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
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
