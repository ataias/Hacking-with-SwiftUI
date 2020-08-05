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



            // TODO Idea: what about user goes to a screen just to fill habits? We send them habits to track for today one by one and he can skip or fill
            // TODO Add a date picker; default is today but user can change
        }
        .onDisappear(perform: saveData)
    }

    func saveData() {
        do {
            let userDir = FileManager.documentsDirectory
            let photoId = UUID()
            let photoDir = userDir.appendingPathComponent("photos", isDirectory: true)
            try FileManager().createDirectory(at: photoDir, withIntermediateDirectories: true)
            let photoFile = photoDir.appendingPathComponent("\(photoId).jpeg")

            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                try jpegData.write(to: photoFile, options: [.atomicWrite, .completeFileProtection])
            }

            let userFile = userDir.appendingPathComponent("users.json")

            var people = [Person]()
            if let data = try? Data(contentsOf: userFile) {
                let decoder = JSONDecoder()
                people = try! decoder.decode([Person].self, from: data)
            }

            let newPerson = Person(firstName: firstName, lastName: lastName, photoId: photoId, notes: notes)
            people.append(newPerson)

            let data = try JSONEncoder().encode(people)
            try data.write(to: userFile, options: [.atomicWrite, .completeFileProtection])
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