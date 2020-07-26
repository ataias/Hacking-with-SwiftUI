//
//  ContentView.swift
//  BucketListTechniques
//
//  Created by Ataias Pereira Reis on 26/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import LocalAuthentication

struct ContentView: View {

    @State private var isUnlocked = false

    var body: some View {
        VStack {
            if self.isUnlocked {
                MapView()
                .edgesIgnoringSafeArea(.all)
            } else {
                Text("Locked")
            }
        }
        .onAppear(perform: authenticate)

    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        // TODO there was a problem
                    }
                }

            }
        } else {
            // TODO no biometrics
            print("There are no biometrics")
        }
    }
}

struct FileManagerView: View {
    var body: some View {
        Text("Hello World")
            .onTapGesture {
                let str = "Test Message"
                let url = FileManager.documentsDirectory.appendingPathComponent("message.txt")

                do {
                    try str.write(to: url, atomically: true, encoding: .utf8)
                    let input = try String(contentsOf: url)
                    print(input)
                } catch {
                    print(error.localizedDescription)
                }
        }
    }
}

struct CustomComparableStructView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
        ].sorted()

    var body: some View {
        List(users) { user in
            Text("\(user.lastName), \(user.firstName)")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
