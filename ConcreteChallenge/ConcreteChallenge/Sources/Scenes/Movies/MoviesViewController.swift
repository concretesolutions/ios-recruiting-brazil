//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func onFetchedLocalMovies(viewModel: Movies.FetchLocalMovies.ViewModel)
    func onFetchedGenres(viewModel: Movies.FetchGenres.ViewModel)
    func displayMovies(viewModel: Movies.FetchMovies.ViewModel)
    func displayGenericError()
    func displayMoviesBySearch(viewModel: Movies.FetchLocalMoviesBySearch.ViewModel)
    func displaySearchError(searchedText: String)
}

final class MoviesViewController: UIViewController, MoviesDisplayLogic {
    private lazy var galleryCollectionView = GridGalleryCollectionView(itemSize: getItemSize(), items: [])

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [galleryCollectionView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var localMovies: [Movie] = []

    private var movies: [Movie] = []

    private var moviesFiltered: [Movie] = []

    private var genres: [GenreResponse] = []

    private var firstTimeFetchMovies = true

    private var currentPage: Int = 0

    private var lastPage: Int?

    private var filter: String = .empty

    // MARK: - Variables

    weak var delegate: MoviesViewControllerDelegate?

    // MARK: - Private constants

    private let interactor: MoviesBusinessLogic

    private let errorView: ErrorView = ErrorViewFactory.make()

    // MARK: - Initializers

    init(interactor: MoviesBusinessLogic) {
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

        // First time has delay only to simulate loading
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.view.showLoading()
            self?.fetchLocalMovies()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !firstTimeFetchMovies {
            fetchLocalMovies()
        }
    }

    // MARK: - Functions

    func filter(search: String) {
        guard !search.isEmpty else {
            clearSearch()
            fetchLocalMovies()
            return
        }

        showGallery()

        filter = search

        let request = Movies.FetchLocalMoviesBySearch.Request(movies: movies, filter: search)
        interactor.fetchLocalMoviesBySearch(request: request)
    }

    // MARK: - MoviesDisplayLogic conforms

    func onFetchedLocalMovies(viewModel: Movies.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies

        fetchGenres()
    }

    func onFetchedGenres(viewModel: Movies.FetchGenres.ViewModel) {
        genres = viewModel.genres

        fetchMovies()
    }

    func displayMovies(viewModel: Movies.FetchMovies.ViewModel) {
        view.stopLoading()

        currentPage = viewModel.page
        lastPage = viewModel.totalPages
        movies.append(contentsOf: viewModel.movies)

        reloadMovies()
    }

    func displayGenericError() {
        displayErrorView()
    }

    func displayMoviesBySearch(viewModel: Movies.FetchLocalMoviesBySearch.ViewModel) {
        moviesFiltered = viewModel.movies

        reloadMovies()
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
        setupAction()
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

    private func setupAction() {
        galleryCollectionView.bindOnItemPress { [weak self] index in
            self?.galleryItemTapped(index)
        }

        galleryCollectionView.bindOnDisplayLastItem { [weak self] in
            self?.fetchNewPageMovies()
        }
    }

    private func galleryItemTapped(_ index: Int) {
        let movieTapped = moviesFiltered.count > 0 ? moviesFiltered[index] : movies[index]

        var localMovie: Movie?
        if let indexTapped = moviesFiltered.firstIndex(of: movieTapped) {
            localMovie = localMovies.first { $0.id == moviesFiltered[indexTapped].id }
        } else if let indexTapped = movies.firstIndex(of: movieTapped) {
            localMovie = localMovies.first { $0.id == movies[indexTapped].id }
        }

        let displayMovieDetails = localMovie ?? movieTapped
        delegate?.galleryItemTapped(movie: displayMovieDetails, self)
    }

    private func fetchNewPageMovies() {
        guard filter.isEmpty, let lastPage = lastPage, currentPage + 1 < lastPage else {
            return
        }

        currentPage += 1
        fetchMovies(page: currentPage)
    }

    private func fetchLocalMovies() {
        showGallery()
        interactor.fetchLocalMovies()
    }

    private func fetchGenres(language: String = Constants.MovieDefaultParameters.language) {
        interactor.fetchGenres(request: Movies.FetchGenres.Request(language: language))
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        // skip fetchMovies if user scroll faster than reloadMovies first time and evit reloadMovies twice before first response
        guard errorView.isHidden else {
            return
        }

        if page == Constants.MovieDefaultParameters.page {
            movies = []
        }

        interactor.fetchMovies(request: Movies.FetchMovies.Request(language: language, page: page, genres: genres))
    }

    private func reloadMovies() {
        firstTimeFetchMovies = false

        let displayMovies = moviesFiltered.count > 0 ? moviesFiltered : movies

        let itemsViewModel = displayMovies.map { movie -> GridGalleryItemViewModel in
            let movieFound = localMovies.first { localMovie -> Bool in
                localMovie.id == movie.id
            }

            movie.isFavorite = movieFound != nil

            return GridGalleryItemViewModel(imageURL: movie.imageURL, title: movie.title, isFavorite: movie.isFavorite)
        }

        galleryCollectionView.setupDataSource(items: itemsViewModel)
    }

    private func showGallery() {
        errorView.isHidden = true
        galleryCollectionView.isHidden = false
    }

    private func clearSearch() {
        filter = .empty
        moviesFiltered = []
    }

    private func displayErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        view.stopLoading()

        galleryCollectionView.isHidden = true
        errorView.isHidden = false

        currentPage = 1
        errorView.configuration = configuration
    }

    private func getItemSize() -> CGSize {
        let verticalMargin = CGFloat(Constants.GridGalleryCollectionView.verticalMargin)
        let horizontalMargin = CGFloat(Constants.GridGalleryCollectionView.horizontalMargin)

        let amountItemVertical = CGFloat(Constants.GridGalleryCollectionView.amountItemVertical)
        let amountItemHorizontal = CGFloat(Constants.GridGalleryCollectionView.amountItemHorizontal)

        let searchViewHeight = CGFloat(52)
        let tabBarHeight = CGFloat(48)

        let heightCell = (view.safeAreaLayoutGuide.layoutFrame.size.height - searchViewHeight - tabBarHeight - verticalMargin * (amountItemVertical + 1)) / amountItemVertical
        let widthCell = (view.safeAreaLayoutGuide.layoutFrame.size.width - horizontalMargin * (amountItemHorizontal + 1)) / amountItemHorizontal

        return CGSize(width: widthCell, height: heightCell)
    }
}
