//
//  ContentView.swift
//  TimesTable
//
//  Created by Ataias Pereira Reis on 13/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            SettingsView()
                .navigationBarTitle("Times Table")
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
