//
//  ImageViewer.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 25/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ImageViewer: View {
    let image: Image?

    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.secondary)
            if image != nil {
                image?
                    .resizable()
                    .scaledToFit()
            } else {
                Text("Tap to select a picture")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
    }
}

struct ImageViewer_Previews: PreviewProvider {
    static var previews: some View {
        ImageViewer(image: nil)
    }
}
