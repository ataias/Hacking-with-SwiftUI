//
//  ContentView.swift
//  SwiftSnapshotTesting
//
//  Created by Ataias Pereira Reis on 08/08/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("common.hello").padding()
            SendButton()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
