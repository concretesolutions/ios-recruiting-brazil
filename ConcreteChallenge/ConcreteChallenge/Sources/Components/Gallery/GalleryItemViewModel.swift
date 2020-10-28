//
//  GalleryItemViewModel.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 27/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct GalleryItemViewModel {
    var movie: Movie
    var itemSize: CGSize

    // MARK: - Initializers

    init(movie: Movie, itemSize: CGSize) {
        self.movie = movie
        self.itemSize = itemSize
    }
}
