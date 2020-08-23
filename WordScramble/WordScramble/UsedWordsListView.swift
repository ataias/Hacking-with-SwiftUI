//
//  UsedWordsListView.swift
//  WordScramble
//
//  Created by Ataias Pereira Reis on 23/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct UsedWordsListView: View {
    let usedWords: [String]

    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        List(Array(zip(usedWords.indices, usedWords)), id: \.0) { index, word in
            GeometryReader { geo in
                HStack {
                    Image(systemName: "\(word.count).circle")
                        .foregroundColor(colors[Int(geo.midY / geo.height) % 7])
                    Text(word)
                }
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text("\(word), \(word.count) letters"))
            .offset(CGSize(width: Double(index) * 10.0, height: 0.0))
        }
    }
}

struct UsedWordsListView_Previews: PreviewProvider {
    static var previews: some View {
        UsedWordsListView(usedWords: Array(repeating: "abnormal", count: 30))
    }
}

extension GeometryProxy {
    var midY: CGFloat {
        self.frame(in: .global).midY
    }

    var height: CGFloat {
        self.size.height
    }
}
