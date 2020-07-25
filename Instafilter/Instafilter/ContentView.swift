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

struct Filter {
    let name: String
    let ciFilter: CIFilter
}

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false

    @State private var currentFilter: Filter = ContentView.filters[4]

    @State private var showingFilterSheet = false
    @State private var showingSaveAlert = false
    @State private var saveMessage = ""

    static let filters: [Filter] = [
        Filter(name: "Crystallize", ciFilter: CIFilter.crystallize()) ,
        Filter(name: "Edges", ciFilter: CIFilter.edges()),
        Filter(name: "Gaussian Blur", ciFilter: CIFilter.gaussianBlur()),
        Filter(name: "Pixellate", ciFilter: CIFilter.pixellate()),
        Filter(name: "Sepia Tone", ciFilter: CIFilter.sepiaTone()),
        Filter(name: "Unsharp Mask", ciFilter: CIFilter.unsharpMask()),
        Filter(name: "Vignette", ciFilter: CIFilter.vignette()),
    ]

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
                    .onTapGesture {
                        self.showingImagePicker = true
                    }

                    HStack {
                        Text("Intensity")
                        Slider(value: intensity, in: 0.0...1.0)
                    }.padding(.vertical)

                    HStack {
                        Button(currentFilter.name) {
                            self.showingFilterSheet = true
                        }

                        Spacer()

                        Button("Save") {
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
                }
                .padding([.horizontal, .bottom])
                .navigationBarTitle("Instafilter")
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
                .actionSheet(isPresented: $showingFilterSheet) {

                    let buttons: [Alert.Button] = (ContentView.filters.map { filter in .default(Text(filter.name), action: { self.setFilter(filter) }) }) + [.cancel()]
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
        currentFilter.ciFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        let inputKeys = currentFilter.ciFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.ciFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.ciFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.ciFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.ciFilter.outputImage else { return }

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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
