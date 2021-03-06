//
//  PhotoNameListView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 31/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PhotoNameListView: View {
    let people: [Person]
    let images: [UUID: UIImage]

    init() {
        let people: [Person] = FileManager.decode(FileManager.userFile) ?? []
        self.people = people.sorted()
        self.images = FileManager.readImages(people)
    }

    init(people: [Person], images: [UUID: UIImage]) {
        self.people = people.sorted()
        self.images = images
    }

    var body: some View {
        List(people) { person in
            NavigationLink(destination: PersonDetailView(person: person, uiImage: images[person.photoId]!)) {
                HStack {
                    Image(uiImage: images[person.photoId]!)
                        .resizable()
                        // this workaround was suggested in
                        // https://www.hackingwithswift.com/forums/100-days-of-swiftui/day-77-images-on-real-iphone-are-distorted/938
                        .aspectRatio(images[person.photoId]!.size, contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipped()
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
    static let location = CLLocationCoordinate2D(latitude: -27.5902, longitude: -48.5425)
    static let basePeople = [
        Person(firstName: "Fulano", lastName: "De Tal", photoId: uuids[0], notes: "Bla", location: location),
        Person(firstName: "Cicrano", lastName: "De Tal", photoId: uuids[1], notes: "Hey Hey", location: location),
    ]
    static let people = (0...20).map { basePeople[$0 % 2] }

    static let red = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 100))
    static let blue = UIImage.getColoredRectImageWith(color: UIColor.blue.cgColor, andSize: CGSize(width: 50, height: 50))
    static let green = UIImage.getColoredRectImageWith(color: UIColor.green.cgColor, andSize: CGSize(width: 50, height: 50))

    static let images = [
        uuids[0]: red,
        uuids[1]: blue,
        uuids[2]: green,
    ]

    static var previews: some View {
        PhotoNameListView(people: people, images: images)
    }
}
