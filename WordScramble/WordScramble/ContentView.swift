//
//  ContentView.swift
//  WordScramble
//
//  Created by Ataias Pereira Reis on 19/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var score = 0

    // Alert state
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            VStack {
                TextField(
                    "Enter your word",
                    text: $newWord,
                    onCommit: addNewWord
                )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                List(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                    .accessibilityElement(children: .ignore)
                    .accessibility(label: Text("\(word), \(word.count) letters"))
                }
                Text("Score: \(score)")
            }
            .navigationBarTitle(rootWord)
            .navigationBarItems(leading:
                Button(action: startGame) {
                    Text("Reset")
                }
            )
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError) {
                Alert(
                    title: Text(errorTitle),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK")))
            }
        }
    }

    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkwork"
                return
            }

        }
        fatalError("Could not load start.txt from bundle.")
    }

    func addNewWord() {
        let answer = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            return
        }

        guard answer != rootWord else {
            wordError(
                title: "Error",
                message: "Word is the root word")
            newWord = ""
            return
        }

        guard isOriginal(word: answer) else {
            wordError(
                title: "Error",
                message: "Word already in the list")
            newWord = ""
            return
        }

        guard isPossible(word: answer) else {
            wordError(
                title: "Error",
                message: "Word can't be made out of root word")
            newWord = ""
            return
        }

        guard isReal(word: answer) else {
            wordError(
                title: "Error",
                message: "Not an English word")
            newWord = ""
            return
        }

        usedWords.insert(answer, at: 0)
        score += answer.count
        newWord = ""
    }

    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }

    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }

    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker
            .rangeOfMisspelledWord(
                in: word,
                range: range,
                startingAt: 0,
                wrap: false,
                language: "en")

        return misspelledRange.location == NSNotFound
    }

    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true

        // if we reached here, newAnswer was invalid and we update the score
        score -= newWord.count
    }


}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
