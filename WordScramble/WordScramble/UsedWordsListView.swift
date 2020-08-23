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

    var body: some View {
        List(Array(zip(usedWords.indices, usedWords)), id: \.0) { index, word in
            HStack {
                Image(systemName: "\(word.count).circle")
                Text(word)
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
