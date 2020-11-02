//
//  FavoritesViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 25/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol FavoritesDisplayLogic: AnyObject {
    func displayLocalMovies(viewModel: Favorites.FetchLocalMovies.ViewModel)
    func displayFetchedLocalMoviesEmpty()
    func displayMovieUnfavorite()
    func displayGenericError()
    func displayMoviesBySearch(viewModel: Favorites.FetchLocalMoviesBySearch.ViewModel)
    func displaySearchError(searchedText: String)
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

    private var localMoviesFiltered: [Movie] = []

    private var filter: FilterSearch = FilterSearch()

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

        filter(newFilter: FilterSearch())
    }

    // MARK: - Functions

    func filter(newFilter: FilterSearch) {
        filter = FilterSearch(search: newFilter.search ?? filter.search,
                                   date: newFilter.date ?? filter.date,
                                   genres: newFilter.genres ?? filter.genres)

        guard !filter.isEmpty else {
            fetchLocalMovies()
            return
        }

        interactor.fetchLocalMoviesBySearch(request: Favorites.FetchLocalMoviesBySearch.Request(movies: localMovies, filter: filter))
    }

    // MARK: - FavoritesDisplayLogic conforms

    func displayLocalMovies(viewModel: Favorites.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies
        localMoviesFiltered = []

        setupViewModel()
    }

    func displayFetchedLocalMoviesEmpty() {
        displayEmptyMovie()
    }

    func displayMovieUnfavorite() {
        print(Strings.movieUnfavoriteSuccessful.localizable)

        if localMovies.count <= 0 {
            displayEmptyMovie()
        }
    }

    func displayGenericError() {
        displayErrorView()
    }

    func displayMoviesBySearch(viewModel: Favorites.FetchLocalMoviesBySearch.ViewModel) {
        localMoviesFiltered = viewModel.movies

        setupViewModel()
    }

    func displaySearchError(searchedText: String) {
        let searchIcon = UIImage(assets: .searchIcon)
        let errorFormatted = String(format: Strings.errorSearch.localizable, searchedText)
        let configurationError = ErrorConfiguration(image: searchIcon, text: errorFormatted)
        displayErrorView(configuration: configurationError)
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
        let movieToRemove = localMoviesFiltered.count > 0 ? localMoviesFiltered[index] : localMovies[index]

        if let indexToRemove = localMovies.firstIndex(of: movieToRemove) {
            localMovies.remove(at: indexToRemove)
        }

        if let indexToRemove = localMoviesFiltered.firstIndex(of: movieToRemove) {
            localMoviesFiltered.remove(at: indexToRemove)
        }

        setupViewModel()

        interactor.deleteMovie(request: Favorites.DeleteMovie.Request(movie: movieToRemove))
    }

    private func setupViewModel() {
        let moviesDisplay = localMoviesFiltered.count > 0 ? localMoviesFiltered : localMovies
        let horizontalItemsViewModel = moviesDisplay.map { movie -> HorizontalInfoListViewModel in
            HorizontalInfoListViewModel(imageURL: movie.imageURL, title: movie.title, subtitle: movie.releaseDate, descriptionText: movie.overview)
        }

        horizontalTableView.setupDataSource(items: horizontalItemsViewModel)
    }

    private func fetchLocalMovies() {
        showHorizontalList()
        interactor.fetchLocalMovies()
    }

    private func showHorizontalList() {
        errorView.isHidden = true
        horizontalTableView.isHidden = false
        clearFilter()
    }

    private func clearFilter() {
        localMoviesFiltered = []
        filter = FilterSearch()
    }

    private func displayEmptyMovie() {
        let searchIcon = UIImage(assets: .searchIcon)
        let configurationError = ErrorConfiguration(image: searchIcon, text: Strings.thereIsNotFavoriteMovie.localizable)
        displayErrorView(configuration: configurationError)
    }

    private func displayErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        horizontalTableView.isHidden = true
        errorView.isHidden = false

        errorView.configuration = configuration
    }
}
