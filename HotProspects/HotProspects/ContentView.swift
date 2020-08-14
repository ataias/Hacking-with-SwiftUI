//
//  ContentView.swift
//  HotProspects
//
//  Created by Ataias Pereira Reis on 10/08/20.
//

import SwiftUI

struct ContentView: View {
    var prospects = Prospects()
    @State private var sortKey = ProspectSortKey.name

    var body: some View {
        TabView {
            ProspectsView(filter: .none, sortKey: $sortKey)
                .tabItem {
                    Image(systemName: "person.3")
                    Text("Everyone")
                }
            ProspectsView(filter: .contacted, sortKey: $sortKey)
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Contacted")
                }
            ProspectsView(filter: .uncontacted, sortKey: $sortKey)
                .tabItem {
                    Image(systemName: "questionmark.diamond")
                    Text("Uncontacted")
                }
            MeView()
                .tabItem {
                    Image(systemName: "person.crop.square")
                    Text("Me")
                }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
