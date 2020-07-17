//
//  Decoder.swift
//  FriendFace
//
//  Created by Ataias Pereira Reis on 17/07/20.
//

import Foundation

class UserDecoder {
    public static var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }()
}
