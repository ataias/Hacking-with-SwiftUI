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

struct Page: Codable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}
