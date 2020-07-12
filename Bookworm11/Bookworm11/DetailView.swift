//
//  DetailView.swift
//  Bookworm11
//
//  Created by Ataias Pereira Reis on 12/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false

    let book: Book

    var formattedLaunchDate: String {
        if let launchDate = book.date {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        }
        return "N/A"
    }


    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    self.image()
                        .resizable()
                        .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height / 3)
                        .clipped()
                    Text(self.book.genre?.uppercased() ?? "UNKNOWN")
                        .font(.caption)
                        .fontWeight(.black)
                        .foregroundColor(Color.white)
                        .padding(8.0)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }

                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)

                Text(self.book.review ?? "No review")
                    .padding()

                Text("Added: \(self.formattedLaunchDate)")
                    .padding()

                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)

                Spacer()

            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
            .alert(isPresented: $showingDeleteAlert) {
                Alert(
                    title: Text("Delete book"),
                    message: Text("Are you sure?"),
                    primaryButton: .destructive(Text("Delete")) {
                        self.deleteBook()
                    },
                    secondaryButton: .cancel()
                )
        }
    }

    func deleteBook() {
        moc.delete(book)
        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }

    func image() -> Image {
        if book.genre?.isEmpty ?? false {
            return Image("Unknown")
        }
        return Image(book.genre ?? "Unknown")
    }


}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = ""
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        book.date = Date()
        return NavigationView {
            DetailView(book: book)
        }
    }
}
