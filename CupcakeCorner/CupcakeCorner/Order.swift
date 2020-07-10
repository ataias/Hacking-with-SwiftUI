//
//  Order.swift
//  CupcakeCorner
//
//  Created by Ataias Pereira Reis on 08/07/20.
//

import SwiftUI

class Storage: ObservableObject, Codable {

    @Published var order = Order()

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order = try container.decode(Order.self, forKey: .order)
    }

    init() { }

    enum CodingKeys: CodingKey {
        case order
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order, forKey: .order)
    }


}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""

    var hasValidAddress: Bool {
        return !(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                    zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
