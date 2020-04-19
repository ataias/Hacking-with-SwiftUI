//
//  ContentView.swift
//  WordScramble
//
//  Created by Ataias Pereira Reis on 19/04/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let names = ["Ataias", "Eduardo", "Amanda", "João"]
    var body: some View {
        List {
            Section(header: Text("Section 1")) {
                Text("Static row 1")
                Text("Static row 2")
            }
            Section(header: Text("Section 2")) {
                ForEach(0..<5) {
                    Text("Dynamic row \($0)")
                }
            }
            Section(header: Text("Section 3")) {
                Text("Static row 3")
            }
            Section(header: Text("Section 4")) {
                ForEach(names, id: \.self) {
                    Text($0)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
