//
//  Sort.swift
//  SnowSeeker
//
//  Created by Ataias Pereira Reis on 30/08/20.
//

import SwiftUI

class Sort: ObservableObject {
    private let saveKey = "Sort"

    private var _sort: Options.Sort

    init() {
        let sortString = UserDefaults.standard.string(forKey: saveKey)
        if let sortString = sortString {
            _sort = Options.Sort(rawValue: sortString)!
        } else {
            _sort = .none
        }
    }

    var sort: Options.Sort {
        get {
            _sort
        }
        set {
            objectWillChange.send()
            _sort = newValue
        }
    }

    private func save() {
        UserDefaults.standard.setValue(sort, forKey: saveKey)
    }
}
