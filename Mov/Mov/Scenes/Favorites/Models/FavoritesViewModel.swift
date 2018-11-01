//
//  FavoritesViewModel.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

struct FavoritesViewModel {
    var title: String
    var posterPath: String
    var year: Int
    var overview: String
    
    
    init(title: String, posterPath: String, year: Int, overview: String) {
        self.title = title
        self.posterPath = posterPath
        self.year = year
        self.overview = overview
    }
    
    init(from unit: FavoritesUnit) {
        self.init(title: unit.title, posterPath: unit.posterPath, year: unit.releaseDate.year, overview: unit.overview)
    }
    
    // empty path will generate nil url, thus making fetchImage get a placeholder poster
    static let placeHolder = FavoritesViewModel(title: "Movie", posterPath: "", year:0, overview: "")
}

extension FavoritesViewModel {
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
