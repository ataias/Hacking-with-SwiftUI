//
//  PersonDetailView.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 05/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PersonDetailView: View {
    let person: Person
    let image: Image

    var date: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: person.createdAt)
    }


    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    HFormItem {
                        Text("Name: ").bold()
                        Text("\(person.firstName) \(person.lastName)")
                    }

                    HFormItem {
                        Text("Meeting Date: ").bold()
                        Text("\(date)")
                    }

                    HFormItem {
                        Text("Notes: ").bold()
                    }

                    Text("\(person.notes)")
                        .padding(.horizontal)
                        .frame(width: geometry.size.width, alignment: .leading)

                    HFormItem {
                        Text("Where I met this person: ").bold()
                        NavigationLink("Lat: \(person.location.latitude); Long: \(person.location.longitude)", destination: MapView(person: person))

                    }

                }
            }
        }
    }
}

struct HFormItem<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        HStack {
            self.content()
            Spacer()
        }
        .padding([.bottom, .horizontal])
    }
}



struct PersonDetailView_Previews: PreviewProvider {
    static let uuid = UUID()
    static let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eius adipisci, sed libero. Iste asperiores suscipit, consequatur debitis animi impedit numquam facilis iusto porro labore dolorem, maxime magni incidunt. Delectus, est!

        Totam at eius excepturi deleniti sed, error repellat itaque omnis maiores tempora ratione dolor velit minus porro aspernatur repudiandae labore quas adipisci esse, nulla tempore voluptatibus cupiditate. Ab provident, atque.
    """

    static let location = CLLocationCoordinate2D(latitude: -27.5902, longitude: -48.5425)
    static let person = Person(firstName: "Fulano", lastName: "De Tal", photoId: uuid, notes: loremIpsum, location: location)
    static let red = UIImage.getColoredRectImageWith(color: UIColor.red.cgColor, andSize: CGSize(width: 50, height: 50))
    static let image = Image(uiImage: red)

    static var previews: some View {
        PersonDetailView(person: person, image: image)
    }
}
