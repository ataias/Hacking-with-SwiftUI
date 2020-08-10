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

class SwiftSnapshotTestingTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }


    func testDefaultAppearance() {
        assertSnapshot(
            matching: SendButton().referenceFrame(),
            as: .image(size: referenceSize)
        )
    }

    func testRightToLeft() {
        let sut = SendButton()
            .referenceFrame()
            .environment(\.layoutDirection, .rightToLeft)

        assertSnapshot(
            matching: sut.referenceFrame(),
            as: .image(size: referenceSize)
        )
    }

    func testPtBRLocale() {
        let sut = SendButton()
            .referenceFrame()
            .environment(\.locale, Locale(identifier: "pt-BR"))

        assertSnapshot(matching: sut.referenceFrame(), as: .image(size: referenceSize))
    }


}


private let referenceSize = CGSize(width: 150, height: 100)
private extension SwiftUI.View {
    func referenceFrame() -> some View {
        self.frame(width: referenceSize.width, height: referenceSize.height)
    }
}
