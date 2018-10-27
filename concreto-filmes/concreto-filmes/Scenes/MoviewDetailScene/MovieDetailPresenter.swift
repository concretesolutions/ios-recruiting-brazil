//
//  MovieDetailPresenter.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright (c) 2018 Leonel Menezes. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentMovie(movie: Movie)
}

class MovieDetailPresenter: MovieDetailPresentationLogic {
    weak var viewController: MovieDetailDisplayLogic?

    func presentMovie(movie: Movie) {
        let genres = movie.genreIDS.map { (id) -> String in
            return Genre.fetchedGenres[id] ?? "Uknown"
        }
        let genresString = genres.joined(separator: ", ")
        
        let viewModel = MovieDetail.ViewModel(movieImageURL: movie.posterPath ?? "", title: movie.title, genres: genresString, overview: movie.overview, isFavorite: false)
        viewController?.displayMovie(viewModel: viewModel)
    }

}
