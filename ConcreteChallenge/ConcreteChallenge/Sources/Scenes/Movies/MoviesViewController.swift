//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

protocol MoviesDisplayLogic: AnyObject {
    func onFetchLocalMoviesSuccess(viewModel: Movies.FetchLocalMovies.ViewModel)
    func onFetchLocalMoviesBySearchSuccess(viewModel: Movies.FetchLocalMoviesBySearch.ViewModel)
    func onFetchGenresSuccess(viewModel: Movies.FetchGenres.ViewModel)
    func displayMoviesItems(viewModel: Movies.FetchMovies.ViewModel)
    func displayMoviesError()
    func displaySearchError(searchText: String)
}

final class MoviesViewController: UIViewController, MoviesDisplayLogic {
    private lazy var galleryCollectionView: GridGalleryCollectionView = {
        return GridGalleryCollectionView(itemSize: getItemSize(), items: [])
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [galleryCollectionView, errorView])
        stackView.axis = .vertical

        return stackView
    }()

    // MARK: - Private variables

    private var localMovies: [Movie] = []

    private var movies: [Movie] = []

    private var moviesToDisplay: [Movie] = []

    private var genres: [GenreResponse] = []

    private var firstTimeLoadMovies = true

    private var currentPage: Int = 0

    private var lastPage: Int?

    private var filter: FilterSearch?

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

        // First time has delay only to show loading view - Should remove lines 71...74
        view.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.fetchLocalMovies()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !firstTimeLoadMovies {
            view.showLoading()
            showGallery()
            fetchLocalMovies()
        }
    }

    // MARK: - Functions

    func filter(filter: FilterSearch) {
        if let search = filter.search, !search.isEmpty {
            interactor.fetchLocalMoviesBySearch(request: Movies.FetchLocalMoviesBySearch.Request(movies: movies, filter: filter))
        } else {
            showGallery()
            fetchMovies()
        }
    }

    // MARK: - MoviesDisplayLogic conforms

    func onFetchLocalMoviesSuccess(viewModel: Movies.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies

        fetchGenres()
    }

    func onFetchLocalMoviesBySearchSuccess(viewModel: Movies.FetchLocalMoviesBySearch.ViewModel) {
        moviesToDisplay = viewModel.movies
        filter = viewModel.search

        loadGridGalleryLayout()
    }

    func onFetchGenresSuccess(viewModel: Movies.FetchGenres.ViewModel) {
        genres = viewModel.genres

        fetchMovies()
    }

    func displayMoviesItems(viewModel: Movies.FetchMovies.ViewModel) {
        view.stopLoading()
        errorView.isHidden = true

        currentPage = viewModel.page
        lastPage = viewModel.totalPages
        movies.append(contentsOf: viewModel.movies)

        loadGridGalleryLayout()
    }

    func displayMoviesError() {
        setErrorView()
    }

    func displaySearchError(searchText: String) {
        let configurationError = ErrorConfiguration(image: UIImage(assets: .searchIcon), text: String(format: Strings.errorSearch.localizable, searchText))
        setErrorView(configuration: configurationError)
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
        galleryCollectionView.bind { [weak self] index in
            self?.galleryItemTapped(index)
        }

        galleryCollectionView.bindOnDisplayLastItem { [weak self] in
            self?.fetchNewMoviesPage()
        }
    }

    private func galleryItemTapped(_ index: Int) {
        let movieFound = localMovies.first { localMovie -> Bool in
            localMovie.id == movies[index].id
        }

        let movieDetails = movieFound ?? movies[index]

        self.delegate?.galleryItemTapped(movie: movieDetails, self)
    }

    private func fetchNewMoviesPage() {
        guard filter == nil else {
            return
        }

        currentPage += 1
        if let lastPage = lastPage, currentPage < lastPage {
            fetchMovies(page: currentPage)
        }
    }

    private func fetchLocalMovies() {
        interactor.fetchLocalMovies()
    }

    private func fetchGenres(language: String = Constants.MovieDefaultParameters.language) {
        interactor.fetchGenres(request: Movies.FetchGenres.Request(language: language))
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        if page == Constants.MovieDefaultParameters.page {
            movies = []
        }

        if errorView.isHidden {
            interactor.fetchMovies(request: Movies.FetchMovies.Request(language: language, page: page, genres: genres))
        }
    }

    private func showGallery() {
        errorView.isHidden = true
        galleryCollectionView.isHidden = false

        moviesToDisplay = []
        filter = nil
    }

    private func setErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        view.stopLoading()

        galleryCollectionView.isHidden = true
        errorView.isHidden = false


        currentPage = 1
        errorView.configuration = configuration
    }

    private func loadGridGalleryLayout() {
        firstTimeLoadMovies = false

        let displayMovies = moviesToDisplay.count > 0 ? moviesToDisplay : movies

        let itemsViewModel = displayMovies.map { movie -> GridGalleryItemViewModel in
            let movieFound = localMovies.first { localMovie -> Bool in
                localMovie.id == movie.id
            }

            movie.isFavorite = movieFound?.isFavorite != nil

            return GridGalleryItemViewModel(imageURL: movie.imageURL, title: movie.title, isFavorite: movie.isFavorite)
        }

        galleryCollectionView.setupDataSource(items: itemsViewModel)
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
