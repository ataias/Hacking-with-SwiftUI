//
//  CLLocationCoordinate2D+Codable.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 07/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import CoreLocation


/// Simple wrapper around CLLocation that is Codable
struct Location: Codable {
    let latitude: Double
    let longitude: Double

    init(location: CLLocationCoordinate2D) {
        self.latitude = location.latitude
        self.longitude = location.longitude
    }

    var CLLocation: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
