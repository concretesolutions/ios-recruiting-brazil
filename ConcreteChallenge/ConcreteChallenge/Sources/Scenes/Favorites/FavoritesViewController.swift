//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func onFetchLocalMoviesSuccess(viewModel: Favorites.FetchLocalMovies.ViewModel)
    func displayMoviesError()
    func displaySearchError(searchText: String)
    func onSuccessDeleteMovie()
}

final class FavoritesViewController: UIViewController, FavoritesDisplayLogic {
    private lazy var horizontalTableView = HorizontalInfoListFactory.makeTableView()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [horizontalTableView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var localMovies: [Movie] = []

    // MARK: - Private constants

    private let interactor: FavoritesBusinessLogic

    private let errorView: ErrorView = ErrorViewFactory.make()

    // MARK: - Initializers

    init(interactor: FavoritesBusinessLogic) {
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        fetchLocalMovies()
    }

    // MARK: - FavoritesDisplayLogic conforms

    func onFetchLocalMoviesSuccess(viewModel: Favorites.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies

        setupViewModel()
    }

    func displayMoviesError() { }

    func displaySearchError(searchText: String) { }

    func onSuccessDeleteMovie() {
        print("movie unfavorite success")
    }

    // MARK: - Private functions

    private func setup() {
        setupLayout()
        setupActions()
    }

    private func setupLayout() {
        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        view.backgroundColor = .white
    }

    private func setupActions() {
        horizontalTableView.bind { [weak self] index in
            self?.horizontalItemTapped(index)
        }
    }

    private func horizontalItemTapped(_ index: Int) {
        let movieToRemove = localMovies[index]
        localMovies.remove(at: index)

        setupViewModel()

        interactor.deleteMovie(request: MovieDetails.DeleteMovie.Request(movie: movieToRemove))
    }

    private func setupViewModel() {
        let horizontalItemsViewModel = localMovies.map { movie -> HorizontalInfoListViewModel in
            HorizontalInfoListViewModel(imageURL: movie.imageURL, title: movie.title, subtitle: movie.releaseDate, descriptionText: movie.overview)
        }

        horizontalTableView.setupDataSource(items: horizontalItemsViewModel)
    }

    private func fetchLocalMovies() {
        interactor.fetchLocalMovies()
    }
}
