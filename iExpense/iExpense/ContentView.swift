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
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text("\(item.amount)")
                            .foregroundColor(self.getExpenseColor(item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(
                leading: EditButton(),
                // TODO Is this a SwiftUI? The button is unresponsive. The first time it works and you can add an item, but afterwards it stops working. I tried investigating if variables were being set correctly, but they seemed ok, except that the button is not triggered anymore after adding an item.
                trailing: Button(action: {
                    self.showingAddExpense = true
                    print(self.showingAddExpense)
                }) {
                    Image(systemName: "plus")
                }
            )
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: self.expenses)
            }
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }

    func getExpenseColor(_ value: Int) -> Color {
        if value <= 10 {
            return Color.blue
        }
        if value <= 100 {
            return Color.green
        }
        return Color.red
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension String {
    func sanitizeDecimal() -> String {
        var value = self
        var parsed = value.filter { "0123456789.".contains($0) }
        let dots = (parsed.filter {$0 == "."}).count

        if parsed != self {
            value = parsed
        }

        if dots > 1 {
            parsed.remove(at: parsed.lastIndex(of: ".")!)
            value = parsed
        }

        return value
    }
}
