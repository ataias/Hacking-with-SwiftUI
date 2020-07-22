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
import UIKit

struct CoreImageTestView: View {
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()

            Button("Select Image") {
                self.showingImagePicker = true
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadInputImage) {
            ImagePicker(image: self.$inputImage)
        }

    }

    func loadInputImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: inputImage)
    }

    func loadImage() {
        guard let inputImage = UIImage(named: "Example") else {
            fatalError("Image does not exist")
        }
        let beginImage = CIImage(image: inputImage)

        let context = CIContext()
//        let currentFilter = CIFilter.crystallize()
////        currentFilter.inputImage = beginImage
//        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter.radius = 2
////        currentFilter.radius

        guard let currentFilter = CIFilter(name: "CITwirlDistortion") else { return }
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(700, forKey: kCIInputRadiusKey)
        currentFilter.setValue(CIVector(x: inputImage.size.width / 2 + 300, y: inputImage.size.height / 2 + 350), forKey: kCIInputCenterKey)

        guard let outputImage = currentFilter.outputImage else {
            print("Pixelation failed")
            return
        }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg).rotate(radians: .pi/2)
            image = Image(uiImage: uiImage)
        } else {
            print("Setting image failed")
        }
    }
}

struct CoreImageTestView_Previews: PreviewProvider {
    static var previews: some View {
        CoreImageTestView()
    }
}

extension UIImage {
    // From StackOverflow
    // https://stackoverflow.com/a/48781122/2304697
    // License: https://creativecommons.org/licenses/by-sa/4.0/
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}
