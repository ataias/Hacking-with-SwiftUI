//
//  EditPhotoInfoView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreLocation

struct EditPhotoInfoView: View {
    let inputImage: UIImage
    let image: Image
    let location: CLLocationCoordinate2D
    @State private var date = Date()
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var notes = ""

    init(uiImage: UIImage, location: CLLocationCoordinate2D) {
        self.inputImage = uiImage
        self.image = Image(uiImage: uiImage)
        self.location = location
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
            let newPerson = Person(firstName: firstName, lastName: lastName, photoId: photoId, notes: notes, location: location)
            try FileManager.save(newPerson)
        } catch {
            print("Unable to save data: \(error.localizedDescription)")
        }
    }

}

struct EditPhotoInfoView_Previews: PreviewProvider {
    static let placeholder = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 50))
    static let location = CLLocationCoordinate2D(latitude: -27.5902, longitude: -48.5425)

    static var previews: some View {
        EditPhotoInfoView(uiImage: placeholder, location: location)
    }
}
