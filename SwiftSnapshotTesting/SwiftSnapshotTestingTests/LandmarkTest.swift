//
//  SwiftSnapshotTestingTests.swift
//  SwiftSnapshotTestingTests
//
//  Created by Ataias Pereira Reis on 08/08/20.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import SwiftSnapshotTesting

private let referenceSize = CGSize(width: 300, height: 70)

class LandmarkTests: XCTestCase {

    let landmark = Landmark(name: "Turtle Rock", imageName: "turtlerock", isFavorite: false)

    func testRenderLandmark() {
        assertSnapshot(
            matching: LandmarkRow(landmark: landmark).referenceFrame(),
            as: .image(size: referenceSize)
        )
    }

}

private extension SwiftUI.View {
    func referenceFrame() -> some View {
        self.frame(width: referenceSize.width, height: referenceSize.height)
    }
}
