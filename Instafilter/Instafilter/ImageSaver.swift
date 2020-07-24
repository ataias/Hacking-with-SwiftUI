//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 24/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import UIKit


class ImageSaver: NSObject {
    func writePhotoToAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }

    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
}
