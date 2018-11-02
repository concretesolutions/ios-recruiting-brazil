//
//  MovieGridViewModel.swift
//  Mov
//
//  Created by Miguel Nery on 25/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

struct MovieGridViewModel: Equatable {
    
    let title: String
    let posterPath: String
    let isFavoriteIcon: UIImage
    
    init(title: String, posterPath: String, isFavoriteIcon: UIImage) {
        self.title = title
        self.posterPath = posterPath
        self.isFavoriteIcon = isFavoriteIcon
    }
    
    init(from unit: MovieGridUnit, isFavoriteIcon: UIImage) {
        self.init(title: unit.title, posterPath: unit.posterPath, isFavoriteIcon: isFavoriteIcon)
    }
    
    
    // empty path will generate nil url, thus making fetchImage get a placeholder poster
    static let placeHolder = MovieGridViewModel(title: "Movie", posterPath: "", isFavoriteIcon: Images.isFavoriteIconGray)
}

extension MovieGridViewModel {
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
