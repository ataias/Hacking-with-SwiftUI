//
//  DummyTestViews.swift
//  This file has a bunch of functions that are not part of iExpense.
//  Instead, there are several small views with code that will later be used in iExpense
//  iExpense
//
//  Created by Ataias Pereira Reis on 15/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

/// Not tested
struct CodableView: View {
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)

            Button("Save User") {
                let encoder = JSONEncoder()
                if let data = try? encoder.encode(self.user) {
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
        }
    }
}

struct UserDefaultsView: View {
    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

    var body: some View {
        VStack {
            Text("The tap count is on UserDefaults")
            Button("Tap count: \(tapCount)") {
                self.tapCount += 1
                UserDefaults.standard.set(self.tapCount, forKey: "Tap")
            }
        }
    }
}

struct OnDeleteListItemView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("\($0)")
                    }
                    .onDelete(perform: removeRows)
                }

                Button("Add Number") {
                    self.numbers.append(self.currentNumber)
                    self.currentNumber += 1
                }
            }
            .navigationBarItems(leading: EditButton())
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct SheetsView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button("Dismiss") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

class OUser: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}

struct ObservedObjectView: View {
    @ObservedObject var user = OUser()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}
