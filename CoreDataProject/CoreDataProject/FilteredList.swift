//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ataias Pereira Reis on 12/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }

    let content: (T) -> Content

    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }

    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }

}