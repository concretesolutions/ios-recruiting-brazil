//
//  MoviesVC+CollectionDelegate.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "movieDetail") as? MovieDetailVC {
            viewController.movie = self.movies[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !isSearchActive {
            if indexPath.row == self.movies.count - 3 {
                if (page > 1) && (!loadingMovies) {
                    getPopularMoviesFromApi()
                }
            }
            
        }
    }
}
