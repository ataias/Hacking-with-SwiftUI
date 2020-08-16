//
//  ContentView.swift
//  Flashzilla
//
//  Created by Ataias Pereira Reis on 15/08/20.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
        }
    }
}
