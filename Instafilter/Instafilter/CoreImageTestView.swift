//
//  CoreImageTestView.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 20/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct CoreImageTestView: View {
    @State private var image: Image?

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)

    }

    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else {
            fatalError("Image does not exist")
        }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
        let currentFilter = CIFilter.sepiaTone()
        currentFilter.inputImage = beginImage
        currentFilter.intensity = 1

        // TODO Continue here
    }
}

struct CoreImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageTestView()
    }
}
