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
    @AppStorage("price") var priceFilter: Int = 3
    @State private var isShowingSheet = false

    var body: some View {
        Button(action: {
            isShowingSheet = true
        }, label: {
            Image(systemName: "line.horizontal.3.decrease")
        })
        .sheet(isPresented: $isShowingSheet, content: {
            Form {
                Section(header: Text("Max Price")) {
                    Picker("Max Price", selection: $priceFilter) {
                        ForEach(1...3, id: \.self) { price in
                            Text(String(repeating: "$", count: price))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
            }
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
