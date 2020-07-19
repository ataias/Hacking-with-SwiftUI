//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 14/07/20.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    let context = PersistentCloudKitContainer.persistentContainer.viewContext

    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, context)
        }
    }


}
