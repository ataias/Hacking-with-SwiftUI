//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Ataias Pereira Reis on 12/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import SwiftUI
import CoreData

enum Filter {
    typealias Key = String
    typealias Value = String
    typealias Values = [String]

    case beginsWith(Key, Value)
    case beginsWithCaseInsensitive(Key, Value)
    case equals(Key, Value)
    case inSet(Key, Values)

    var predicate: NSPredicate {
        switch self {
        case .beginsWith(let key, let value):
            return NSPredicate(format: "%K BEGINSWITH %@", key, value)
        case .beginsWithCaseInsensitive(let key, let value):
            return NSPredicate(format: "%K BEGINSWITH[c] %@", key, value)
        case .equals(let key, let value):
            return NSPredicate(format: "%K == %@", key, value)
        case .inSet(let key, let values):
            return NSPredicate(format: "%K IN %@", key, values)
        }
    }

}


struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }

    let content: (T) -> Content

    init(filter: Filter, sortDescriptors: [NSSortDescriptor] = [], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: filter.predicate)
        self.content = content
    }

    var body: some View {
        List(items, id: \.self) { item in
            self.content(item)
        }
    }

}
