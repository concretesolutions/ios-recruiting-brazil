//
//  FavoritesCollectionViewDataSource.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 02/03/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
/**
Favorites Feed Data Source
 */
class FavoritesCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var viewController: FavoriteViewController?
    
    init(viewController: FavoriteViewController) {
        self.viewController = viewController
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewController?.searchedMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MovieCollectionView.cellId, for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Wrong Cell ID")
        }

        if let movies = viewController?.searchedMovies {
            cell.movieImage.kf.indicatorType = .activity
            let movie = movies[indexPath.item]
            cell.movieTitle.text = movie.title
            viewController?.presenter?.changeButtonImage(button: cell.favoriteButton, movie: movie)
            cell.favoriteButton.tag = movie.id
            cell.favoriteButton.addTarget(self, action: #selector(handleFavorite(_:)), for: .touchUpInside)
            let moviePosterImageURL = viewController?.presenter?.getMovieImageURL(width: 200, path: movie.posterPath ?? "")
            cell.movieImage.kf.setImage(with: moviePosterImageURL) { result in
                switch result {
                case .failure(let error): print("Não foi possivel carregar a imagem:", error.localizedDescription)
                    // Tratar o error
                cell.movieImage.image = UIImage(named: Constants.ErrorValues.loadingImageError)
                default: break
                }
            }
        }
        return cell
    }
    
    // MARK: - Favorite Button Action
    @objc func handleFavorite(_ sender: UIButton) {
        var cellMovie: Movie?
        guard let movies = viewController?.presenter?.movies else { return }
        for movie in movies {
            if movie.id == sender.tag {
                cellMovie = movie
            }
        }
        guard let movie = cellMovie else { return }
        viewController?.presenter?.handleMovieFavorite(movie: movie)
        viewController?.presenter?.changeButtonImage(button: sender, movie: movie)
     }
}
