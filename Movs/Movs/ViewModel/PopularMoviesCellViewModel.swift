//
//  PopularMoviesCellViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import UIKit
import Combine

class PopularMoviesCellViewModel {

    private var movie: Movie

    private(set) var title: String
    @Published var posterImage: UIImage = UIImage()
    @Published var isLiked: Bool = false

    var posterImageCancellable: AnyCancellable?
    var isLikedCancellable: AnyCancellable?

    init(withMovie movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.setCombine()
    }

    private func setCombine() {
        self.isLikedCancellable = self.movie.$isLiked.assign(to: \.isLiked, on: self)
        self.posterImageCancellable = self.movie.$posterImage.assign(to: \.posterImage, on: self)
    }

    public func toggleFavorite() {
        PersistenceService.favorite(movie: self.movie)
    }

}
