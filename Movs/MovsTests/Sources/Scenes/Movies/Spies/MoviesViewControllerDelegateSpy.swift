//
//  MoviesViewControllerDelegateSpy.swift
//  MovsTests
//
//  Created by Adrian Almeida on 03/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

@testable import Movs

final class MoviesViewControllerDelegateSpy: MoviesViewControllerDelegate {
    private(set) var invokedGalleryItemTapped = false
    private(set) var invokedGalleryItemTappedCount = 0
    private(set) var invokedGalleryItemTappedParameters: (movie: Movie, viewController: MoviesViewController)?
    private(set) var invokedGalleryItemTappedParametersList = [(movie: Movie, viewController: MoviesViewController)]()

    // MARK: - MoviesViewControllerDelegate conforms

    func galleryItemTapped(movie: Movie, _ viewController: MoviesViewController) {
        invokedGalleryItemTapped = true
        invokedGalleryItemTappedCount += 1
        invokedGalleryItemTappedParameters = (movie, viewController)
        invokedGalleryItemTappedParametersList.append((movie, viewController))
    }
}
