//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func onSuccessSaveMovie(viewModel: MovieDetails.SaveMovie.ViewModel)
    func onSuccessDeleteMovie(viewModel: MovieDetails.DeleteMovie.ViewModel)
}

final class MovieDetailsViewController: UIViewController, MovieDetailsDisplayLogic {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: movieDisplay.imageURL))

        return imageView
    }()

    private lazy var moviesDetailsInfoListView = InfoListTableViewFactory.makeTableView(movie: movieDisplay)

    // MARK: - Private constants

    private var movieData: Movie

    private var movieDisplay: Movie {
        didSet {
            setupMoviesInfo()
        }
    }

    private let interactor: MovieDetailsBusinessLogic

    // MARK: - Initializers

    init(movie: Movie, interactor: MovieDetailsBusinessLogic) {
        movieData = movie
        movieDisplay = movie.clone()
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func setupNavigation() {
        super.setupNavigation()
        title = Strings.movie.localizable
    }

    // MARK: - MovieDetailsDisplayLogic Conforms

    func onSuccessSaveMovie(viewModel: MovieDetails.SaveMovie.ViewModel) {
        movieDisplay.isFavorite = viewModel.isFavorite
        setupMoviesInfo()
    }

    func onSuccessDeleteMovie(viewModel: MovieDetails.DeleteMovie.ViewModel) {
        movieData = movieDisplay.clone()
        movieDisplay.isFavorite = viewModel.isFavorite
        setupMoviesInfo()
    }

    // MARK: - Private functions

    private func setup() {
        setupNavigation()
        setupLayout()
        setupMoviesInfo()
    }

    private func setupLayout() {
        view.addSubview(imageView, constraints: [
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])

        view.addSubview(moviesDetailsInfoListView, constraints: [
            moviesDetailsInfoListView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            moviesDetailsInfoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            moviesDetailsInfoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            moviesDetailsInfoListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])

        view.backgroundColor = .white
    }

    private func setupMoviesInfo() {
        let icon: UIImage.Assets = movieDisplay.isFavorite ? .favoriteFullIcon : .favoriteEmptyIcon

        let action: (() -> Void) = { [weak self] in
            self?.actionButtonTapped()
        }

        let infoListItemsViewModel = [
            InfoListItemViewModel(title: movieDisplay.title, icon: icon, action: action),
            InfoListItemViewModel(title: movieDisplay.releaseDate),
            InfoListItemViewModel(title: movieDisplay.genres),
            InfoListItemViewModel(descriptionText: movieDisplay.overview)
        ].filter { infoListItemViewModel in
            !infoListItemViewModel.isEmpty
        }

        moviesDetailsInfoListView.setupDataSource(items: infoListItemsViewModel)
    }

    private func actionButtonTapped() {
        if !movieDisplay.isFavorite {
            interactor.saveMovie(request: MovieDetails.SaveMovie.Request(movie: movieData))
        } else {
            interactor.deleteMovie(request: MovieDetails.DeleteMovie.Request(movie: movieData))
        }
    }
}
