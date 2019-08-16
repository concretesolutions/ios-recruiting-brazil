//
//  MoviesViewController.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import os
import SnapKit
import UIKit

class MoviesViewController: UIViewController {

    //CollectionView
    let collectionView = MoviesGridCollectionView()
    var collectionViewDataSource: MoviesGridCollectionDataSource?
    //swiftlint:disable weak_delegate
    var collectionViewDelegate: MoviesGridCollectionDelegate?
    //Auxiliar Views
    lazy var activityIndicator = ActivityIndicator(frame: .zero)
    var errorView = ErrorView(frame: .zero)
    lazy var emptySearchView = EmptySearchView(frame: .zero)
    //SearchController
    let searchController = UISearchController(searchResultsController: nil)
    private var viewModel: MoviesViewModelable

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        os_log(.fault, log: .general, "init(coder:) has not been implemented")
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        self.viewModel = DependencyResolver.shared.resolve(MoviesViewModelable.self)
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupSearchBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        registerObservers()
        viewModel.loadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterObservers()
    }

    func handleFetchOf(movies: [Movie]) {
        self.setupCollectionView(with: movies)
    }

    func setupCollectionView(with movies: [Movie]) {
        collectionViewDataSource = MoviesGridCollectionDataSource(movies: movies, collectionView: self.collectionView, pagingDelegate: self)
        self.collectionView.dataSource = collectionViewDataSource
        collectionViewDelegate = MoviesGridCollectionDelegate(movies: movies, delegate: self)
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.reloadData()
    }

}

// MARK: - CodeView protocol
extension MoviesViewController: CodeView {

    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
        view.addSubview(emptySearchView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        errorView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        emptySearchView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Handling with UI changings

extension MoviesViewController {

    private func refreshUI(for presentationState: PresentationState) {
        switch presentationState {
        case .loadingContent:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            errorView.isHidden = true
            emptySearchView.isHidden = true
        case .displayingContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            errorView.isHidden = true
            emptySearchView.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            errorView.isHidden = false
            emptySearchView.isHidden = true
        case .emptySearch:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            errorView.isHidden = true
            emptySearchView.isHidden = false
        }
    }
}

// MARK: - delegates
extension MoviesViewController: MoviesSelectionDelegate {

    func didSelectMovie(movie: Movie) {
        var selectedMovie = movie
        var movieGenres: [Genre] = []
        for genre in movie.genres {
            movieGenres.append(contentsOf: viewModel.genres.value.filter { $0.id == genre.id })
        }
        selectedMovie.genres = movieGenres
        let movieDetailController = MovieDetailTableViewController(movie: selectedMovie)
        movieDetailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}

extension MoviesViewController: MoviesGridPagingDelegate {

    func shouldFetch(page: Int) {
        viewModel.shouldFetch(page: page)
    }
}

extension MoviesViewController: UISearchBarDelegate {

    func setupSearchBar() {
        self.searchController.searchBar.delegate = self
        navigationItem.searchController = self.searchController
        definesPresentationContext = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.movieSearchText = searchBar.text ?? ""
        searchController.dismiss(animated: true, completion: nil)
    }
}

extension MoviesViewController: Registrable {

    func registerAdditionalObservers() {
        viewModel.initialize()
        viewModel.filteredMovies.bind { movies in
            DispatchQueue.main.async {
                self.handleFetchOf(movies: movies)
            }
        }
        viewModel.presentationState.bind { presentationState in
            DispatchQueue.main.async {
                self.refreshUI(for: presentationState)
            }
        }
    }
}
