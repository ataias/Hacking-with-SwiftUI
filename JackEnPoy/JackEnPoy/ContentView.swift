//
//  ContentView.swift
//  JackEnPoy
//
//  Created by Ataias Pereira Reis on 13/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]

    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var shouldWin = true

    var body: some View {
        VStack(spacing: 20) {
            Text("Jack En Poy")
                .titled()

            if shouldWin {
                Text("You should win")
            } else {
                Text("You should lose")
            }

            Spacer()
            VStack(spacing: 30) {
                ForEach(0 ..< moves.count) { n in
                    Button(action: {
                        // do something
                    }) {
                        MoveImage(image: self.moves[n])
                    }
                }
            }
//            Score(wins: wins, count: count)

        }
        .gradiented()
        .foregroundColor(.white)
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

struct Score: View {
    let wins: Int
    let count: Int

    var body: some View {
        Text("Score: \(wins)/\(count)")
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
