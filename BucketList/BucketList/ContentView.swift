//
//  ContentView.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 26/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import MapKit
import LocalAuthentication

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false
    @State private var showingAuthError = false
    @State private var authErrorMessage = ""

    @State private var isUnlocked = false

    var body: some View {
        ZStack {
            if isUnlocked {
                MainMapView(centerCoordinate: $centerCoordinate, locations: $locations, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, showingEditScreen: $showingEditScreen)
            } else {
                CapsuleButton(text: "UnlockPlaces", perform: self.authenticate)
            }
        }
        .alert(isPresented: $showingAuthError) {
            Alert(title: Text("Auth Error"), message: Text(authErrorMessage), dismissButton: .default(Text("Ok")))
        }
        .onAppear(perform: loadData)
        .sheet(isPresented: $showingEditScreen, onDismiss: saveData, content: {
            if self.selectedPlace != nil {
                EditView(placemark: self.selectedPlace!)
            }
        })
    }

    func loadData() {
        let filename = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")

        do {
            let data = try Data(contentsOf: filename)
            locations = try JSONDecoder().decode([CodableMKPointAnnotation].self, from: data)
        } catch {
            print("Unable to load saved data: \(error)")
        }
    }

    func saveData() {
        do {
            let filename = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
            let data = try JSONEncoder().encode(self.locations)
            // complete file protection will set encryption for us!
            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
            print("Saved Data!")
        } catch {
            print("Unable to save data.")
        }
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
                        self.showingAuthError = true
                        self.authErrorMessage = authenticationError.debugDescription
                    }
                }
            }
        } else {
            // no biometrics
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
