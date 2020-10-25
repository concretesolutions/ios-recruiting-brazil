//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, MoviesDisplayLogic {
    private lazy var worker: MoviesWorker = MoviesWorker()

    private lazy var presenter: MoviesPresenter = MoviesPresenter(moviesDisplayLogic: self)

    private lazy var interactor: MoviesBusinessLogic = {
        return MoviesInteractor(worker: worker, presenter: presenter)
    }()

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

//        let provider = MovieDBNetworkService()
//        provider.getMovies()
    }

    // MARK: - MoviesDisplayLogic conforms

    func displayMoviesItems(viewModel: MoviesModels.MoviesItems.ViewModel) {
        // TODO - load collection view
    }
}
