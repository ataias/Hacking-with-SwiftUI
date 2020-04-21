//
//  ContentView.swift
//  Animations
//
//  Created by Ataias Pereira Reis on 20/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AnimatedBindings()
    }
}

struct AnimatedBindings: View {
    @State private var animationAmount: CGFloat = 1
    var body: some View {
        print(animationAmount)
        return (
            VStack {
                Stepper(
                    "Scale amount",
                    value: $animationAmount.animation(),
                    in: 1...10)
                Spacer()
                Button("Tap Me") {
                    self.animationAmount += 1
                }
                .padding(40)
                .background(Color.red)
                .foregroundColor(.white)
                .clipShape(Circle())
                .scaleEffect(animationAmount)
            }
            )
            .padding()
    }
}

struct AnimatedCircle: View {
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Button("Tap Me") {
            self.animationAmount += 1
        }
        .padding(50)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(Color.red)
                .scaleEffect(animationAmount)
                .opacity(Double(2 - animationAmount))
                .scaleEffect(animationAmount)
                .blur(radius: (animationAmount - 1) * 3)
                .animation(
                    Animation.easeIn(duration: 1)
                        .repeatForever(autoreverses: true)))
            .onAppear {
                self.animationAmount = 2
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
