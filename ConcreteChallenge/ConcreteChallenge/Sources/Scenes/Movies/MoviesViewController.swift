//
//  MovieViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 23/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class MoviesViewController: UIViewController, MoviesDisplayLogic {
    private lazy var galleryCollectionView: GalleryCollectionView = {
        return GalleryCollectionView(itemSize: getItemSize(), items: [])
    }()

    private lazy var stackView: UIStackView = {
        return UIStackView(arrangedSubviews: [galleryCollectionView, errorView])
    }()

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
        setupLayout()
        fetchMovies()
    }

    // MARK: - MoviesDisplayLogic conforms

    func displayMoviesItems(viewModel: MoviesModels.MoviesItems.ViewModel) {
        errorView.isHidden = true

        let itemsViewModel = viewModel.moviesResponse.movies.map { item -> GalleryItemViewModel in
            GalleryItemViewModel(movie: item)
        }

        galleryCollectionView.setupDataSource(items: itemsViewModel)
    }

    func displayMoviesError() {
        setErrorView()
    }

    func displaySearchError(searchText: String) {
        let configurationError = ErrorConfiguration(image: UIImage(assets: .searchIcon), text: String(format: Strings.errorSearch.localizable, searchText))
        setErrorView(configuration: configurationError)
    }

    // MARK: - Private functions

    private func setupLayout() {
        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        view.backgroundColor = .white
    }

    private func fetchMovies(language: String = Constants.MovieDefaultParameters.language, page: Int = Constants.MovieDefaultParameters.page) {
        interactor.fetchMovies(request: MoviesModels.MoviesItems.Request(language: language, page: page))
    }

    private func setErrorView(configuration: ErrorConfiguration = ErrorConfiguration()) {
        galleryCollectionView.isHidden = true

        errorView.configuration = configuration
    }

    private func getItemSize() -> CGSize {
        let verticalMargin = CGFloat(Constants.GalleryCollectionView.verticalMargin)
        let horizontalMargin = CGFloat(Constants.GalleryCollectionView.horizontalMargin)

        let amountItemVertical = CGFloat(Constants.GalleryCollectionView.amountItemVertical)
        let amountItemHorizontal = CGFloat(Constants.GalleryCollectionView.amountItemHorizontal)

        let searchViewHeight = CGFloat(52)
        let tabBarHeight = CGFloat(48)

        let heightCell = (view.safeAreaLayoutGuide.layoutFrame.size.height - searchViewHeight - tabBarHeight - verticalMargin * (amountItemVertical + 1)) / amountItemVertical
        let widthCell = (view.safeAreaLayoutGuide.layoutFrame.size.width - horizontalMargin * (amountItemHorizontal + 1)) / amountItemHorizontal

        return CGSize(width: widthCell, height: heightCell)
    }
}
