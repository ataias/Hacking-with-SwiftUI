//
//  Result.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 27/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?

    var description: String {
        terms?["description"]?.first ?? "No further information"
    }

    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
