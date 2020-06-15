//
//  ContentView.swift
//  iExpense
//
//  Created by Ataias Pereira Reis on 15/06/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    let id = UUID() // Notice the UUID is automatically assigned!
    let name: String
    let type: String
    let amount: Int
}

class Expenses: ObservableObject {
    init() {
        let decoder = JSONDecoder()

        if let data = UserDefaults.standard.data(forKey: "Items") {
            if let items = try? decoder.decode([ExpenseItem].self, from: data) {
                self.items = items
                return
            }
        }

        self.items = []
    }

    @Published var items: [ExpenseItem] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
