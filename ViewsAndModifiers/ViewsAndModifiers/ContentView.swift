//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Ataias Pereira Reis on 12/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var useRedText = false

    var body: some View {
        VStack(spacing: 10) {
            Text("This is a proeminent title")
                .h1titled()
            CapsuleText(text: "First")
                .foregroundColor(.white)
            CapsuleText(text: "Second")
                .foregroundColor(.yellow)

            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with swift")

            GridStack(rows: 4, columns: 4) { row, col in
                Image(systemName: "\(row * 4 + col).circle")
                Text("R\(row) C\(col)")

            }
        }
    }
}

struct CapsuleText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(Color.black)
        }
    }
}

struct H1Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        self.modifier(Watermark(text: text))
    }

    func h1titled() -> some View {
        self.modifier(H1Title())
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    init(rows: Int,
         columns: Int,
         @ViewBuilder content: @escaping (Int, Int) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<self.columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
