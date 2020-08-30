//
//  SnowSeekerApp.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import SwiftUI

@main
struct SnowSeekerApp: App {
    @StateObject var sort = Sort()
    @StateObject var favorites = Favorites()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(favorites)
                .environmentObject(sort)
        }
    }
}
