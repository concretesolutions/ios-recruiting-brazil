//
//  MovieDetailsViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
    private(set) var movie: Movie
    
    private(set) var posterImg: UIImage?
    private(set) var titleText: String
    private(set) var yearText: String = ""
    private(set) var genresText: String = ""
    private(set) var descriptionText: String
    private(set) var favoriteBtnImg: UIImage?
    
    private var isFavorite: Bool {
        return self.movieService.isFavorite(movie: self.movie)
    }
    
    private var movieService: MovieServiceProtocol
    
    init(with service: MovieServiceProtocol, posterImg: UIImage?=nil, andMovie movie: Movie) {
        self.movieService = service
        
        self.movie = movie
        
        self.posterImg = posterImg
        self.titleText = movie.title
        
        if let releaseDate = self.movie.releaseDate {
            self.yearText = releaseDate.yearString
        }
        
        self.descriptionText = self.movie.overview
        
        self.genresText = self.movieService.getGenresString(for: movie)
        self.favoriteBtnImg = self.isFavorite ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
    }
    
    func onFavoriteTapped() {
        // TODO: change favorite status via service
        self.movieService.toggleFavorite(for: self.movie, completion: nil)
        self.favoriteBtnImg = self.isFavorite ? UIImage(systemName: "heart.fill")! : UIImage(systemName: "heart")!
    }
}
