//
//  User.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 07/07/20.
//

// When a class is observable and has published objects, extra work is needed ot make it codable

import SwiftUI

class User: ObservableObject, Codable {
    @Published var name = "Paul Jonhson"

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    enum CodingKeys: CodingKey {
        case name
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}
