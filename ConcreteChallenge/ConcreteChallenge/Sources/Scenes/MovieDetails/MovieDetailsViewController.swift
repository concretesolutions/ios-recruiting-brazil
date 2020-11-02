//
//  MovieDetailsViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 29/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol MovieDetailsDisplayLogic: AnyObject {
    func displayFavoriteIcon()
    func displayUnfavoriteIcon()
}

final class MovieDetailsViewController: UIViewController, MovieDetailsDisplayLogic {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.kf.setImage(with: URL(string: movieDisplay.imageURL))

        return imageView
    }()

    private lazy var movieDetailsInfoListView = InfoListTableViewFactory.make()

    // MARK: - Private variables

    private var movieData: Movie

    private var movieDisplay: Movie

    // MARK: - Private constants

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

    func displayFavoriteIcon() {
        movieDisplay.isFavorite = true
        setupMoviesInfo()
    }

    func displayUnfavoriteIcon() {
        movieData = movieDisplay.clone()
        movieDisplay.isFavorite = false
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

        view.addSubview(movieDetailsInfoListView, constraints: [
            movieDetailsInfoListView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            movieDetailsInfoListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            movieDetailsInfoListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            movieDetailsInfoListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
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

        movieDetailsInfoListView.setupDataSource(items: infoListItemsViewModel)
    }

    private func actionButtonTapped() {
        if !movieDisplay.isFavorite {
            interactor.saveMovie(request: MovieDetails.SaveMovie.Request(movie: movieData))
        } else {
            interactor.deleteMovie(request: MovieDetails.DeleteMovie.Request(movie: movieData))
        }
    }
}
