//
//  GridGalleryItemViewModel.swift
//  Movs
//
//  Created by Adrian Almeida on 27/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct GridGalleryItemViewModel {
    var imageURL: String
    var title: String
    var isFavorite: Bool

    // MARK: - Initializers

    init(imageURL: String, title: String, isFavorite: Bool) {
        self.imageURL = imageURL
        self.title = title
        self.isFavorite = isFavorite
    }
}
