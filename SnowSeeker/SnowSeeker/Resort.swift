//
//  Resort.swift
//
//
//  Created by Ataias Pereira Reis on 29/08/20.
//

import Foundation

struct Resort: Codable, Identifiable {
    let id: String
    let name: String
    let country: String
    let description: String
    let imageCredit: String
    let price: Int
    let size: Int
    let snowDepth: Int
    let elevation: Int
    let runs: Int
    let facilities: [String]

    var facilityTypes: [Facility] {
        facilities.map(Facility.init)
    }

    static let allResorts: [Resort] = Bundle.main.decode("resorts.json")
    static let example = allResorts[0]
}

extension Array where Element == Resort {
    func sorted(by: Options.Sort) -> [Element] {
        switch by {
        case .none:
            return self
        case .alphabetical:
            return self.sorted { $0.name < $1.name }
        case .country:
            return self.sorted { $0.country < $1.country }
        }
    }
}
