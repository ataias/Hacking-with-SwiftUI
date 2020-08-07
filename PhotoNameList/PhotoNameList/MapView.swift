//
//  MapView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 07/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let person: Person

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator

        let location = person.location.CLLocation
        let annotation = MKPointAnnotation()
        annotation.title = "Where I met \(person.firstName)"
        annotation.subtitle = "Full Name: \(person.firstName) \(person.lastName)"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)

        mapView.centerCoordinate = location

        // zoom the region
        let region = MKCoordinateRegion( center: location, latitudinalMeters: CLLocationDistance(exactly: 5000)!, longitudinalMeters: CLLocationDistance(exactly: 5000)!)
        mapView.setRegion(mapView.regionThatFits(region), animated: true)

        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }

    }
}
