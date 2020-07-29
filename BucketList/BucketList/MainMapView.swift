//
//  MainMapView.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 29/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import MapKit

struct MainMapView: View {
    @Binding var centerCoordinate: CLLocationCoordinate2D
    @Binding var locations: [CodableMKPointAnnotation]
    @Binding var selectedPlace: MKPointAnnotation?
    @Binding var showingPlaceDetails: Bool
    @Binding var showingEditScreen: Bool

    var body: some View {
        ZStack {
            MapView(centerCoordinate: $centerCoordinate, selectedPlace: $selectedPlace, showingPlaceDetails: $showingPlaceDetails, annotations: locations)
                .edgesIgnoringSafeArea(.all)
            BigBlueCircle()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    PlusButton(perform: self.addNewLocation)
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
    }

    func addNewLocation() {
        let newLocation = CodableMKPointAnnotation()
        newLocation.title = "Example title"
        newLocation.coordinate = self.centerCoordinate
        self.locations.append(newLocation)
        self.selectedPlace = newLocation
        self.showingEditScreen = true
    }
}

//
//struct MainMapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainMapView()
//    }
//}
