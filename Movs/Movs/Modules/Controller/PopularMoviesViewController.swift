//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController {

    // MARK: - Screen

    private lazy var screen = PopularMoviesScreen()

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Movies"
        self.navigationItem.largeTitleDisplayMode = .always

        self.screen.startLoading()

        DataProvider.shared.setup { error in
            DispatchQueue.main.async {
                self.screen.stopLoading()
            }

            if error != nil {
                DispatchQueue.main.async {
                    self.screen.displayError()
                }
            } else {
                var indexPaths: [IndexPath] = []
                for row in 0...DataProvider.shared.movies.count-1 {
                    indexPaths.append(IndexPath(row: row, section: 0))
                }

                DispatchQueue.main.async {
                    self.screen.collectionView.insertItems(at: indexPaths)
                }
            }
        }
    }
}

extension PopularMoviesViewController: PopularMoviesScreenDelegate {

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DataProvider.shared.movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularMovieCell.reusableIdentifier, for: indexPath) as? PopularMovieCell else {
            fatalError("Wrong collection view cell type")
        }

        cell.delegate = self
        cell.configure(with: DataProvider.shared.movies[indexPath.row])

        return cell
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == DataProvider.shared.movies.count - 1 {
            DataProvider.shared.getMoreMovies { error in
                if error != nil {
                    let alert = UIAlertController(title: "Error", message: "Could not load more movies", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default))
 
                    DispatchQueue.main.async {
                        self.present(alert, animated: true)
                    }
                } else {
                    var indexPaths: [IndexPath] = []
                    for row in indexPath.row+1...DataProvider.shared.movies.count-1 {
                        indexPaths.append(IndexPath(row: row, section: 0))
                    }

                    DispatchQueue.main.async {
                        self.screen.collectionView.insertItems(at: indexPaths)
                    }
                }
            }
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = 170.0
        let height = width * 1.76
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellWidth: CGFloat = 170

        let numberOfCells = floor(collectionView.frame.size.width / cellWidth)
        let edgeInsets = (collectionView.frame.size.width - (numberOfCells * cellWidth)) / (numberOfCells + 1)

        return UIEdgeInsets(top: 0, left: edgeInsets, bottom: 0, right: edgeInsets)
    }

    // MARK: - UICollectionViewDelegate

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(movie: DataProvider.shared.movies[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
