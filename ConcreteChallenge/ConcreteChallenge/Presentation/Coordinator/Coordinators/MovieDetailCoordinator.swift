//
//  MovieDetailCoordinator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MovieDetailCoordinator: Coordinator {
    var rootViewController: RootViewController

    private let movie: Movie
    private lazy var viewModel = DefaultMovieViewModel(
        movie: movie,
        imageRepository: DefaultMovieImageRepository(imagesProvider: URLSessionFileProvider()),
        genresRepository: DefaultGenresRepository(genresProvider: URLSessionJSONParserProvider())
    )
    private lazy var movieDetailViewController = MovieDetailViewController(viewModel: viewModel)
    
    init(rootViewController: RootViewController, movie: Movie) {
        self.movie = movie
        self.rootViewController = rootViewController
    }
    
    func start(previousController: UIViewController?) {
        previousController?.present(movieDetailViewController, animated: true, completion: nil)
    }
}
