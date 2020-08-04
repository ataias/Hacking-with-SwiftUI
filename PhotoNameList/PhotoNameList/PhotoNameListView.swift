//
//  PhotoNameListView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 31/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct PhotoNameListView: View {
    let people: [Person]
    let images: [UUID: Image]

    init() {
        let userDir = FileManager.documentsDirectory
        let userFile = userDir.appendingPathComponent("users.json")

        var people = [Person]()
        if let data = try? Data(contentsOf: userFile) {
            let decoder = JSONDecoder()
            people = try! decoder.decode([Person].self, from: data)
        }

        let photoDir = userDir.appendingPathComponent("photos", isDirectory: true)
        var images = [UUID: Image]()
        people.forEach { person in
            let photoFile = photoDir.appendingPathComponent("\(person.photoId).jpeg")
            guard let data = try? Data(contentsOf: photoFile) else {
                fatalError("Image does not exist")
            }
            guard let uiImage = UIImage(data: data) else {
                fatalError("Couldn't convert image")
            }
            images[person.photoId] = Image(uiImage: uiImage)
        }

        self.people = people
        self.images = images
    }

    init(people: [Person], images: [UUID: Image]) {
        self.people = people
        self.images = images
    }

    var body: some View {
        // TODO Add detail view when user clicks
        List(people) { person in
            NavigationLink(destination: Text("TODO")) {
                HStack {
                    images[person.photoId]?
                        .resizable()
                        .scaledToFit()
                    VStack(alignment: .leading) {
                        Text(person.firstName)
                        Text(person.lastName)
                    }
                }
                .frame(maxHeight: 50)
            }
        }
    }
}

struct PhotoNameListView_Previews: PreviewProvider {
    static let uuids: [UUID] = (0...2).map { _ -> UUID in UUID() }
    static let basePeople = [
        Person(firstName: "Fulano", lastName: "De Tal", photoId: uuids[0]),
        Person(firstName: "Cicrano", lastName: "De Tal", photoId: uuids[1]),
    ]
    static let people = (0...20).map { basePeople[$0 % 2] }

    static let red = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 50))
    static let blue = UIImage.getColoredRectImageWith(color: UIColor.blue.cgColor, andSize: CGSize(width: 50, height: 50))
    static let green = UIImage.getColoredRectImageWith(color: UIColor.green.cgColor, andSize: CGSize(width: 50, height: 50))

    static let images = [
        uuids[0]: Image(uiImage: red),
        uuids[1]: Image(uiImage: blue),
        uuids[2]: Image(uiImage: green),
    ]

    static var previews: some View {
        PhotoNameListView(people: people, images: images)
    }
}
