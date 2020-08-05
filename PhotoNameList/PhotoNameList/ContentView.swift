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
                PhotoNameListView()
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
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: self.$inputImage)
                }
            }
        )
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
