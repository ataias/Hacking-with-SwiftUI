//
//  EditPhotoInfoView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct EditPhotoInfoView: View {
    let inputImage: UIImage
    let image: Image
    @State private var date = Date()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var notes = ""

    init(uiImage: UIImage) {
        self.inputImage = uiImage
        self.image = Image(uiImage: uiImage)
    }

    var body: some View {
        Form {
            Section(header:
                Text("Info").font(.headline)
            ) {
                self.image
                    .resizable()
                    .scaledToFit()
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $firstName)
            }

            Section(header: Text("DATE"), content: {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
            })

            Section(header: Text("Notes"), content: {
                TextField("", text: $notes)
            })



            // TODO Idea: what about user goes to a screen just to fill habits? We send them habits to track for today one by one and he can skip or fill
            // TODO Add a date picker; default is today but user can change
        }
    }
}

struct EditPhotoInfoView_Previews: PreviewProvider {
    static let placeholder = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 50))

    static var previews: some View {
        EditPhotoInfoView(uiImage: placeholder)
    }
}
