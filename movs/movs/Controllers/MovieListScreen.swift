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
    @IBOutlet private weak var searchBar: UISearchBar!

    // MARK: - Properties
    private let dataPresenter = MoviesDataPresenter()
    private var allModels = [Movie]() {
        didSet {
            filteredModels = allModels
        }
    }

    private var filteredModels = [Movie]() {
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            guard let movie = sender as? Movie,
                let screen = segue.destination as? DetailsScreen else {
                    return
            }

			screen.setup(movie: movie)
        }
    }
}

// MARK: - Private
extension MovieListScreen {
    private func setupUI() {
        moviesCollectionView.register(MovieListCell.self)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        searchBar.backgroundColor = .yellowConcrete
        tabBarController?.tabBar.unselectedItemTintColor = .black
    }

    private func fetchData() {
        dataPresenter.getMovies { [weak self] movies in
            self?.allModels = movies
        }
    }
}

// MARK: - UICollectionViewDataSource
extension MovieListScreen: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
		return filteredModels.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieListCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
		cell.setup(movie: filteredModels[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MovieListScreen: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailsSegue",
                     sender: filteredModels[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellWidth = (collectionView.frame.size.width / 2) - 10
        return CGSize(width: cellWidth, height: collectionView.frame.size.height / 2)
    }
}

// MARK: - UISearchBarDelegate
extension MovieListScreen: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredModels = searchText.isEmpty ? allModels : allModels.filter({ movie -> Bool in
            return movie.name.range(of: searchText, options: .caseInsensitive) != nil
        })
    }
}
