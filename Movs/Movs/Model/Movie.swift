//
//  Movie.swift
//  Movs
//
//  Created by Lucca Ferreira on 17/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation
import Combine
import UIKit

class Movie {

    private(set) var id: Int
    private(set) var overview: String
    private(set) var releaseDate: String
    private(set) var genreIds: [Int]
    private(set) var title: String
    private(set) var posterPath: String?
    
    @Published var isLiked: Bool = false
    @Published var posterImage: UIImage = UIImage(named: "imagePlaceholder")!

    private var posterImageCancellable: AnyCancellable?
    
    init(withMovie movie: MovieDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genreIds
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = PersistenceService.favoriteMovies.contains(self.id)
        self.setCombine()
    }

    init(withMovieDetails movie: MovieWrapperDTO) {
        self.id = movie.id
        self.overview = movie.overview
        self.releaseDate = movie.releaseDate
        self.genreIds = movie.genres.compactMap { $0.id }
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.isLiked = PersistenceService.favoriteMovies.contains(self.id)
        self.setCombine()

    }

    private func setCombine() {
        self.posterImageCancellable = MovsService.shared.getMoviePoster(fromPath: self.posterPath).assign(to: \.posterImage, on: self)
    }
    
    func toggleFavorite() {
        PersistenceService.toggleFavorite(self)
        self.isLiked = PersistenceService.favoriteMovies.contains(self.id)
    }

}
