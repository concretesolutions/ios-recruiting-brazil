//
//  MovieDetailsViewModel.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit


struct MovieDetailsViewModel: Equatable {
    var title: String
    var posterPath: String
    var isFavoriteIcon: UIImage
    var year: String
    var genres: [String]
    var overview: String
    
    init(title: String, posterPath: String, isFavoriteIcon: UIImage, year: String, genres: [String], overview: String) {
        self.title = title
        self.posterPath = posterPath
        self.isFavoriteIcon = isFavoriteIcon
        self.year = year
        self.genres = genres
        self.overview = overview
    }
    
    init(from unit: MovieDetailsUnit) {
        let isFavoriteIcon = unit.isFavorite ? Images.isFavoriteIconFull : Images.isFavoriteIconGray
        self.init(title: unit.title, posterPath: unit.posterPath, isFavoriteIcon: isFavoriteIcon, year: String(unit.releaseDate.year), genres: unit.genres, overview: unit.overview)
    }
    
    static let placeHolder = MovieDetailsViewModel(title: "Title", posterPath: "", isFavoriteIcon: Images.isFavoriteIconGray, year: "Year", genres: ["genre1", "genre2"], overview: "Overview")
}

extension MovieDetailsViewModel {
    static let imageFetcher: ImageFetcher = ImageKingFisherGateway()
    
    func fetchImage(to imageView: UIImageView) {
        let imageUrl = API.TMDB.imageBase?.appendingPathComponent(self.posterPath)
        
        if let url = imageUrl {
            MovieGridViewModel.imageFetcher.fetchImage(from: url, to: imageView)
        } else {
            imageView.image = Images.poster_placeholder
        }
    }
}
