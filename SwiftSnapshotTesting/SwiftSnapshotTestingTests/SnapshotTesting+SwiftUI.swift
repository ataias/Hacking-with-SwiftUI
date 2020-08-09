//
//  SnapshotTesting+SwiftUI.swift
//  SwiftSnapshotTestingUITests
//
//  Created by Ataias Pereira Reis on 08/08/20.
//

import SnapshotTesting
import SwiftUI

// reference: https://github.com/V8tr/SnapshotTestingSwiftUI/blob/master/SnapshotTestingSwiftUITests/SnapshotTesting%2BSwiftUI.swift

extension Snapshotting where Value: SwiftUI.View, Format == UIImage {
    static func image(
    drawHierarchyInKeyWindow: Bool = false,
    precision: Float = 1,
    size: CGSize? = nil,
    traits: UITraitCollection = .init()
        ) -> Snapshotting {
            Snapshotting<UIViewController, UIImage>.image(
    drawHierarchyInKeyWindow: drawHierarchyInKeyWindow,
    precision: precision,
    size: size,
    traits: traits
            )
            .pullback(UIHostingController.init(rootView:))
        }
}
