//
//  ActionMenuView.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 30/08/20.
//

import SwiftUI

enum Options {
    enum Sort: String, CaseIterable {
        case none
        case alphabetical
        case country
    }

    enum Filter: String, CaseIterable {
        case country
        case size
        case price

        static let saveKey = "Filter"
    }
}


class Filter: ObservableObject {
    private var filters: [Options.Filter]
    private let saveKey = "Filters"

    init() {
        let stringFilters = UserDefaults.standard.stringArray(forKey: saveKey) ?? []
        filters = stringFilters.compactMap(Options.Filter.init)
    }

    func set(_ filters: [Options.Filter]) {
        objectWillChange.send()
        self.filters = filters
        save()
    }

    func save() {
        let stringArray = filters.map(\.rawValue)
        UserDefaults.standard.setValue(stringArray, forKey: saveKey)
    }
}

struct SortButton: View {
    @EnvironmentObject var sort: Sort
    @State private var isShowingSheet = false

    var body: some View {
        return (
            Button(action: {
                isShowingSheet = true
            }, label: {
                Image(systemName: "arrow.up.arrow.down")
            })
            .sheet(isPresented: $isShowingSheet, content: {

                Form {
                    Picker(selection: $sort.sort, label: Text("Sort")) {
                        ForEach(Options.Sort.allCases, id: \.self) { sortOption in
                            Text("\(sortOption.rawValue)")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }

            })
        )
    }
}

struct FilterButton: View {
    @ObservedObject private var filter = Filter()

    var body: some View {
        Button(action: {}, label: {
            Image(systemName: "line.horizontal.3.decrease")
        })
    }
}


struct ActionMenuView: View {
    var body: some View {
        HStack {
            SortButton()
            FilterButton()
        }
    }
}

struct ActionMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ActionMenuView()
            .font(.largeTitle)
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
    }
}
