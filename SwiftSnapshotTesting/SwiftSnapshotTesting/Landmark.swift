//
//  Landmark.swift
//  SwiftSnapshotTesting
//
//  Created by Ataias Pereira Reis on 09/08/20.
//

import Foundation
import SwiftUI

struct Landmark {
    var name: String
    var imageName: String
    var isFavorite: Bool
}

struct LandmarkRow: View {
    var landmark: Landmark

    var body: some View {
        HStack {
            Image(landmark.imageName)
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
            Spacer()

            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }
    }
}
