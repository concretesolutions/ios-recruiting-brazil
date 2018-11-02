//
//  MovieDetailPresenter.swift
//  Movs
//
//  Created by Ricardo Rachaus on 28/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresentationLogic {
    
    weak var viewController: MovieDetailDisplayLogic!
    
    func present(response: MovieDetail.Response) {
        let year = String(response.movie.releaseDate.split(separator: "-")[0])
        let genres = response.movie.genres.map { (genre) -> String in
            return genre.name
        }
        let genre = genres.joined(separator: ", ")
        let favoriteImageName = response.isFavorite ? Constants.ImageName.favoriteFull : Constants.ImageName.favoriteGray
        let favoriteImage = UIImage(named: favoriteImageName)!
        let viewModel = MovieDetail.ViewModel(title: response.movie.title, year: year, genre: genre, overview: response.movie.overview, favoriteImage: favoriteImage, imageView: response.imageView)
        viewController.display(viewModel: viewModel)
    }
    
}
