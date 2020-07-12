//
//  ContentView.swift
//  Bookworm11
//
//  Created by Ataias Pereira Reis on 11/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>

    @State private var showingAddScreen = false
    var body: some View {
        NavigationView {
            VStack {
                List(books, id: \.self.id) { book in
                    VStack {
                        Text(book.title!)
                    }
                }

            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
                    .environment(\.managedObjectContext, self.moc)
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingAddScreen.toggle()
            }) {
                Image(systemName: "plus")
            })
                .navigationBarTitle("Bookworm")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
