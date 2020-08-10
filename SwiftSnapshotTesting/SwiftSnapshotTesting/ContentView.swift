//
//  ContentView.swift
//  SwiftSnapshotTesting
//
//  Created by Ataias Pereira Reis on 08/08/20.
//

import SwiftUI

struct ContentView: View {
    @State private var text = "Placeholder"
    var body: some View {
        VStack {
            VStack(alignment: .trailing) {
                Text("Hello World!").font(.subheadline).padding()
                HStack {
                    Text("Another")
                }
                SendButton()
                    .padding(.horizontal)
                    .blur(radius: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            }
            TextEditor(text: $text)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .environment(\.locale, Locale(identifier: "pt-BR"))
        }
    }
}
