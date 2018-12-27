//
//  MovieListScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

final class MovieListScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var moviesCollectionView: UICollectionView!

    // MARK: - Properties
    private let dataPresenter = MoviesDataPresenter()
    private var models = [Movie]() {
        didSet {
            moviesCollectionView.reloadData()
        }
    }
}

// MARK: - Lifecycle
extension MovieListScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
}

// MARK: - Private
extension MovieListScreen {
    private func setupUI() {
        moviesCollectionView.register(MovieListCell.self)
    }

    private func fetchData() {
        dataPresenter.getMovies { [weak self] movies in
            self?.models = movies
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
		return models.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
		cell.setup(movie: models[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListScreen: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
		// TO DO
    }
}
