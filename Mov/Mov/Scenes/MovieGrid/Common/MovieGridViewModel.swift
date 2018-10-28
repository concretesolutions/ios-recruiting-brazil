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

extension MovieGridViewModel {
    // empty path will generate nil url, thus making fetchImage get a placeholder poster
    static let placeHolder = MovieGridViewModel(title: "Movie", posterPath: "", isFavoriteIcon: Images.isFavoriteIconGray)
}
