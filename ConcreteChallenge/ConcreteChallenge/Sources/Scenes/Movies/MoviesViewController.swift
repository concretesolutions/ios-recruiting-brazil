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

    private var genres: [GenreResponse] = []

    private var firstTimeLoadMovies = true

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

        // First time has delay only to show loading view
        view.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [weak self] in
            self?.fetchLocalMovies()
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        if !firstTimeLoadMovies {
            view.showLoading()
            fetchLocalMovies()
        }
    }

    // MARK: - MoviesDisplayLogic conforms

    func onFetchLocalMoviesSuccess(viewModel: Movies.FetchLocalMovies.ViewModel) {
        localMovies = viewModel.movies

        fetchGenres()
    }

    func onFetchGenresSuccess(viewModel: Movies.FetchGenres.ViewModel) {
        genres = viewModel.genres

        fetchMovies()
    }

    func displayMoviesItems(viewModel: Movies.FetchMovies.ViewModel) {
        view.stopLoading()
        errorView.isHidden = true

        self.movies = viewModel.movies

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
    }

    private func galleryItemTapped(_ index: Int) {
        let movieFound = localMovies.first { localMovie -> Bool in
            localMovie.id == movies[index].id
        }

        let movieDetails = movieFound ?? movies[index]

        self.delegate?.galleryItemTapped(movie: movieDetails, self)
    }

    private func fetchLocalMovies() {
        interactor.fetchLocalMovies()
    }

    private func fetchGenres(language: String = Constants.MovieDefaultParameters.language) {
        interactor.fetchGenres(request: Movies.FetchGenres.Request(language: language))
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        interactor.fetchMovies(request: Movies.FetchMovies.Request(language: language, page: page, genres: genres))
    }

    private func setErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        view.stopLoading()

        galleryCollectionView.isHidden = true
        errorView.isHidden = false

        errorView.configuration = configuration
    }

    private func loadGridGalleryLayout() {
        firstTimeLoadMovies = false

        let itemsViewModel = movies.map { movie -> GridGalleryItemViewModel in
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
