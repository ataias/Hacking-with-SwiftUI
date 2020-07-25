//
//  Filter.swift
//  Instafilter
//
//  Created by Ataias Pereira Reis on 25/07/20.
//  Copyright © 2020 ataias. All rights reserved.
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins

struct Filter {
    let name: String
    let ci: CIFilter

    static let all: [Filter] = [
        Filter(name: "Crystallize", ci: CIFilter.crystallize()) ,
        Filter(name: "Edges", ci: CIFilter.edges()),
        Filter(name: "Gaussian Blur", ci: CIFilter.gaussianBlur()),
        Filter(name: "Pixellate", ci: CIFilter.pixellate()),
        Filter(name: "Sepia Tone", ci: CIFilter.sepiaTone()),
        Filter(name: "Unsharp Mask", ci: CIFilter.unsharpMask()),
        Filter(name: "Vignette", ci: CIFilter.vignette()),
    ]
}
