//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 22/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import UIKit

class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished")
    }
}
