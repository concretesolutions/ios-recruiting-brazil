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
    private var movies = [Movie]()
    private let urlSessionProvider = URLSessionProvider()
    private var currentPage = 1

    // MARK: - Lifecycle
    override func loadView() {
        self.view = popularMoviesListView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        popularMoviesListView.collectionView.dataSource = self
        popularMoviesListView.collectionView.delegate = self

        fetchMoviesList()
    }

    private func fetchMoviesList() {
        let service = MovieDBService.popularMovies(currentPage)
        popularMoviesListView.viewState = .loading
        urlSessionProvider.request(type: PopularMoviesRoot.self, service: service) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.currentPage = data.page
                    self.movies.append(contentsOf: data.results)
                    self.popularMoviesListView.collectionView.reloadData()
                    self.popularMoviesListView.viewState = .ready
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

}

// MARK: - UICollectionViewDataSource
extension PopularMoviesListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PopularMovieCollectionViewCell
        let movie = movies[indexPath.row]

        cell.setup(movie: movie)

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension PopularMoviesListViewController: UICollectionViewDelegateFlowLayout {
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
