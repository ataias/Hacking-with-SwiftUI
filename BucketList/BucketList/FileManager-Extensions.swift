//
//  FileManager-Extensions.swift
//  BucketList
//
//  Created by Ataias Pereira Reis on 28/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}
