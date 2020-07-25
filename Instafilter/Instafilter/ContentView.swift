//
//  ContentView.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 23/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false

    @State private var currentFilter: Filter = Filter.all[4]

    @State private var showingFilterSheet = false
    @State private var showingSaveAlert = false
    @State private var saveMessage = ""

    let context = CIContext()

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            }
        )

        return (
            NavigationView {
                VStack {
                    ImageViewer(image: image)
                        .onTapGesture { self.showingImagePicker = true }
                    HStack {
                        Text("Intensity")
                        Slider(value: intensity, in: 0.0...1.0)
                    }.padding(.vertical)

                    HStack {
                        Button(currentFilter.name) { self.showingFilterSheet = true }
                        Spacer()
                        Button("Save") { self.saveImage() }
                    }
                }
                .padding([.horizontal, .bottom])
                .navigationBarTitle("Instafilter")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
                .actionSheet(isPresented: $showingFilterSheet) {
                    let buttons: [Alert.Button] = (Filter.all.map { filter in .default(Text(filter.name), action: { self.setFilter(filter) }) }) + [.cancel()]
                    return (
                        ActionSheet(title: Text("Select a filter"), buttons: buttons)
                    )
                }
                .alert(isPresented: $showingSaveAlert) {
                    Alert(title: Text("Save Status"), message: Text(saveMessage), dismissButton: .cancel())
                }
            }
        )
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.ci.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.ci.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.ci.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.ci.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.ci.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.ci.outputImage else { return }

        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            processedImage = uiImage
            image = Image(uiImage: uiImage)
        }
    }

    func setFilter(_ filter: Filter) {
        currentFilter = filter
        loadImage()
    }

    func saveImage() {
        guard let processedImage = self.processedImage else {
            self.saveMessage = "Oops: there is no image selected!"
            self.showingSaveAlert = true
            return
        }

        let imageSaver = ImageSaver()
        imageSaver.successHandler = {
            self.saveMessage = "Success!"
            self.showingSaveAlert = true
        }

        imageSaver.errorHandler = {
            self.saveMessage = "Oops: \($0.localizedDescription)"
            self.showingSaveAlert = true
        }
        imageSaver.writePhotoToAlbum(image: processedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
