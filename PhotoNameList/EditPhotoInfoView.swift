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
                TextField("Last Name", text: $lastName)
            }

            Section(header: Text("DATE"), content: {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: .date) {
                    Text("Select a date")
                }
            })

            Section(header: Text("Notes"), content: {
                TextField("", text: $notes)
            })
        }
        .onDisappear(perform: saveData)
    }

    func saveData() {
        do {
            let photoId = try FileManager.save(inputImage)
            let newPerson = Person(firstName: firstName, lastName: lastName, photoId: photoId, notes: notes)
            try FileManager.save(newPerson)
        } catch {
            print("Unable to save data: \(error.localizedDescription)")
        }
    }

}

struct EditPhotoInfoView_Previews: PreviewProvider {
    static let placeholder = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 50))

    static var previews: some View {
        EditPhotoInfoView(uiImage: placeholder)
    }
}
