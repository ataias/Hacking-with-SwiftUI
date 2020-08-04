//
//  ContentView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 31/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var inputImage: UIImage?

    @State private var showingImagePicker = false
    //    @State private var showingSaveAlert = false
    //    @State private var saveMessage = ""

    // TODO Every time a new image is added, save the file again; on open, read the file to initialize data

    // TODO In Content View, you should only have the basic functionality to read and write from the file; you give that data to a child view then
    var body: some View {
        let showingNewPhotoEdit = Binding<Bool>(
            get: {
                self.inputImage != nil
            },
            set: {
                if !$0 {
                    self.inputImage = nil
                }
            }
        )

        return (
            NavigationView {
                // TODO get actual arguments
                PhotoNameListView(people: [], images: [UUID: Image]())
                    .navigationBarTitle("PhotoNameList")
                    .navigationBarItems(trailing: Button(action: {
                        self.showingImagePicker = true
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                            .sheet(isPresented: showingNewPhotoEdit) {
                                if self.inputImage != nil {
                                    EditPhotoInfoView(uiImage: self.inputImage!)
                                }
                            }
                    }))
                    // TODO Right now it only allows you to select the image, but there is no processing
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: self.$inputImage)
                }
            }
        )
    }

    // TODO load data from file and images
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
