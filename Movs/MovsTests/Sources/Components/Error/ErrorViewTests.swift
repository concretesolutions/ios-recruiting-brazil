//
//  ErrorViewTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 02/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import SnapshotTesting
import XCTest
@testable import Movs

final class ErrorViewTests: XCTestCase {

    override class func setUp() {
        super.setUp()

        isRecording = false
    }

    func testShouldShowErroView() {
        let sut = ErrorView()

        snapshot(sut: sut, named: #function)
    }

    func testShoulShowErrorViewChangeIcon() throws {
        let sut = ErrorView()
        let favoriteFullIconImage = try XCTUnwrap(UIImage(assets: .favoriteFullIcon))
        sut.image = favoriteFullIconImage

        snapshot(sut: sut, named: #function)
    }

    func testShoulShowErrorViewChangeText() {
        let sut = ErrorView()
        sut.text = "Server error"

        snapshot(sut: sut, named: #function)
    }

    func testShouldShowErrorViewWithConfiguration() {
        let searchImage = UIImage(assets: .searchIcon)
        let errorMessage = "Communication error"
        let configuration = ErrorConfiguration(image: searchImage, text: errorMessage)
        let sut = ErrorView(configuration: configuration)

        snapshot(sut: sut, named: #function)
    }

    func testShouldErroViewByFactoryMakeIsHidden() {
        let sut = ErrorViewFactory.make()

        snapshot(sut: sut, named: #function)
    }

    // MARK: - Private functions

    private func snapshot(sut: ErrorView, named: String) {
        let sutViewController = addSubviewForTest(equalConstraintsFor: sut)

        assertSnapshot(matching: sutViewController, as: .image, named: named)
    }

//    private func snapshot() -> UIViewController {
//        let errorView = ErrorView()
//
//        let sut = addSubviewForTest(errorView) { (viewController: UIViewController) -> [NSLayoutConstraint] in
//            [
//                errorView.topAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.topAnchor),
//                errorView.leadingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.leadingAnchor),
//                errorView.trailingAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.trailingAnchor),
//                errorView.bottomAnchor.constraint(equalTo: viewController.view.safeAreaLayoutGuide.bottomAnchor)
//            ]
//        }
//
//        return sut
//    }
}
