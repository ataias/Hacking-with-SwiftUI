//
//  ContentView.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 26/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    @State private var locations = [CodableMKPointAnnotation]()
    @State private var selectedPlace: MKPointAnnotation?
    @State private var showingPlaceDetails = false
    @State private var showingEditScreen = false

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 32, height: 32)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        let newLocation = CodableMKPointAnnotation()
                        newLocation.title = "Example title"
//                        newLocation.subtitle = "Example subtitle"
                        newLocation.coordinate = self.centerCoordinate
                        self.locations.append(newLocation)
                        self.selectedPlace = newLocation
                        self.showingEditScreen = true
                    }) {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .foregroundColor(.white)
                    .font(.title)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
        }
        .alert(isPresented: $showingPlaceDetails) {
            let title = Text(selectedPlace?.title ?? "Unknown")
            let message = Text(selectedPlace?.subtitle ?? "Missing place information")
            let primaryButton = Alert.Button.default(Text("OK"))
            let secondaryButton = Alert.Button.default(Text("Edit")) {
                self.showingEditScreen = true
            }

            return (
                Alert(title: title, message: message, primaryButton: primaryButton, secondaryButton: secondaryButton)
            )
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
