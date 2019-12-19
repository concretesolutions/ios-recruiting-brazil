//
//  FavoriteMoviesCellViewModel.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

class FavoriteMoviesCellViewModel {

    private var movie: Movie
    
    private(set) var title: String
    private(set) var overview: String
    private(set) var releaseDate: String
    @Published var posterImage: UIImage = UIImage()

    private var posterImageCancellable: AnyCancellable?

    init(withMovie movie: Movie) {
        self.movie = movie
        self.title = movie.title
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.setCombine()
    }

    private func setCombine() {
        self.posterImageCancellable = self.movie.$posterImage.assign(to: \.posterImage, on: self)
    }

}
