//
//  PopularMoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Matheus Oliveira Costa on 14/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

class PopularMoviesListViewController: UIViewController {

    // MARK: - Properties
    private let popularMoviesListView = PopularMoviesListView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var movies = [Movie]()
    private var filteredMovies = [Movie]()
    private let urlSessionProvider = URLSessionProvider()
    private var currentPage = 1

    weak var coordinator: PopularMoviesTabCoordinator?

    var viewState: PopularMoviesListView.State {
        get { return popularMoviesListView.viewState }
        set { popularMoviesListView.viewState = newValue }
    }

    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }

    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    // MARK: - Lifecycle
    override func loadView() {
        self.view = popularMoviesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Filmes populares"

        popularMoviesListView.collectionView.dataSource = self
        popularMoviesListView.collectionView.delegate = self

        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true

        definesPresentationContext = true

        viewState = .loading
        fetchMoviesList()
    }

    private func fetchMoviesList() {
        let service = MovieDBService.popularMovies(currentPage)
        urlSessionProvider.request(type: PopularMoviesRoot.self, service: service) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.movies.append(contentsOf: data.results)
                    self.popularMoviesListView.collectionView.reloadData()
                    self.viewState = .ready
                    self.fetchPosterImages()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.popularMoviesListView.viewState = .error
                }
            }
        }
    }

    private func fetchPosterImages() {
        for (index, movie) in movies.enumerated() {
            let service = MovieDBService.posterImage(movie.posterPath)
            urlSessionProvider.request(service: service) { result in
                switch result {
                case .success(let imageData):
                    DispatchQueue.main.async { [weak self] in
                        self?.movies[index].posterImage = UIImage(data: imageData)
                        self?.popularMoviesListView.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    private func favorite(movie: Movie) {
        let newFavorite = FavoriteMovie(context: CoreDataStore.context)
        newFavorite.title = movie.title
        newFavorite.id = Int64(movie.id)
        newFavorite.overview = movie.overview
        newFavorite.posterImage = movie.posterImage?.jpegData(compressionQuality: 1.0)
        newFavorite.genreIDs = movie.genreIDs.map({ NSNumber(value: $0) })

        CoreDataStore.saveContext()
    }

}

// MARK: - UICollectionViewDataSource
extension PopularMoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredMovies.count : movies.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PopularMovieCollectionViewCell

        let movie: Movie
        if isFiltering {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }

        cell.setup(movie: movie) {
            self.favorite(movie: movie)
        }

        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.row == movies.count - 1 && !(viewState == .fetchingContent) {
            fetchMoviesList()
            viewState = .fetchingContent
        }
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopularMoviesListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie: Movie
        if isFiltering {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }
        coordinator?.showDetails(of: movie)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let padding = collectionView.contentInset.left + collectionView.contentInset.right + 10
        let itemWidth = (collectionView.frame.width - padding) / 2
        return CGSize(width: itemWidth, height: itemWidth * 1.5)
    }
}

// MARK: - UISearchBarDelegate, UISearchResultsUpdating
extension PopularMoviesListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(for: searchController.searchBar.text!)
    }

    private func filterContent(for searchText: String) {
        filteredMovies = movies.filter({ movie -> Bool in
            return movie.title.range(of: searchText, options: .caseInsensitive) != nil
        })

        if isFiltering && filteredMovies.count == 0 {
            viewState = .empty
        } else {
            viewState = .ready
        }

        popularMoviesListView.collectionView.reloadData()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        popularMoviesListView.collectionView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        popularMoviesListView.collectionView.reloadData()
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewState = .ready
    }
}
