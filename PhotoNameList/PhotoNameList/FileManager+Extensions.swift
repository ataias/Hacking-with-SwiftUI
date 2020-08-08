//
//  FileManager+Extensions.swift
//  PhotoNameList
//
//  Created by Ataias Pereira Reis on 03/08/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }

    static let userFile = FileManager.documentsDirectory.appendingPathComponent("users.json")

    static var photoDir: URL = {
        let userDir = FileManager.documentsDirectory
        let photoDir = userDir.appendingPathComponent("photos", isDirectory: true)
        try! FileManager().createDirectory(at: photoDir, withIntermediateDirectories: true)
        return photoDir
    }()

    static func decode<T: Codable>(_ url: URL) -> T? {

        if !FileManager.default.fileExists(atPath: url.path) {
            return nil
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(url) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(url) from bundle")
        }

        return loaded
    }

    /// Saves an image to the user photo folder
    /// - Parameter uiImage: the image to be saved
    /// - Returns: the UUID used in the name of the saved filed
    static func save(_ uiImage: UIImage) throws -> UUID {
        let photoId = UUID()
        let photoFile = FileManager.photoDir.appendingPathComponent("\(photoId).jpeg")

        if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
            try jpegData.write(to: photoFile, options: [.atomicWrite, .completeFileProtection])
        }

        return photoId
    }


    static func save(_ person: Person) throws {
        var people: [Person] = FileManager.decode(userFile) ?? []
        people.append(person)
        let data = try JSONEncoder().encode(people)
        try data.write(to: userFile, options: [.atomicWrite, .completeFileProtection])
    }

    static func readImages(_ people: [Person]) -> [UUID: UIImage] {
        var images = [UUID: UIImage]()
        people.forEach { person in
            let photoFile = photoDir.appendingPathComponent("\(person.photoId).jpeg")
            guard let data = try? Data(contentsOf: photoFile) else {
                fatalError("Image does not exist")
            }
            guard let uiImage = UIImage(data: data) else {
                fatalError("Couldn't convert image")
            }
            images[person.photoId] = uiImage
        }
        return images
    }


}
