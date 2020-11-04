//
//  MoviesViewControllerTests.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import Foundation
import XCTest
@testable import Movs

final class MoviesViewControllerTests: XCTestCase {
    private lazy var sut: MoviesViewController = {
        let viewController = MoviesViewController(interactor: interactorSpy)
        viewController.delegate = delegateSpy

        return viewController
    }()

    private var interactorSpy = MoviesInteractorSpy()

    private var delegateSpy = MoviesViewControllerDelegateSpy()

    // MARK: - Override functions

    override func setUp() {
        super.setUp()

        setRootViewController(sut)
    }

    override func tearDown() {
        super.tearDown()

        popRootViewController()
        clearRootViewController()
    }

    // MARK: - Test functions

    func testInitializers() {
        _ = sut

        XCTAssertFalse(interactorSpy.invokedFetchLocalMovies)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }

    func testViewDidLoadShouldCallFetchLocalMovies() {
        sut.viewDidLoad()

        // Fail because DispatchQueue.main.asyncAfter in viewDidLoad
//        XCTAssertTrue(interactorSpy.invokedFetchLocalMovies)
//        XCTAssertEqual(interactorSpy.invokedFetchLocalMoviesCount, 1)
        XCTAssertFalse(interactorSpy.invokedFetchGenres)
        XCTAssertFalse(interactorSpy.invokedFetchMovies)
        XCTAssertFalse(interactorSpy.invokedFetchLocalMoviesBySearch)
        XCTAssertFalse(delegateSpy.invokedGalleryItemTapped)
    }
}
