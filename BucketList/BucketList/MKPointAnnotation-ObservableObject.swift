//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 27/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get {
            self.title ?? "Unknown Value"
        }

        set {
            title = newValue
        }
    }

    public var wrappedSubtitle: String {
        get {
            self.subtitle ?? "Unknown value"
        }

        set {
            subtitle = newValue
        }
    }
}
