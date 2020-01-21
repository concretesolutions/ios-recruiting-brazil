//
//  MoviesVC+CollectionDataSource.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

extension MoviesVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchActive {
            if filteredMovies.count == 0 {
                setBackgroundErrorView(withText: "Sua busca por '\(textSearched)' não resultou em nenhum resultado.",
                                       image: UIImage(named: "search_icon"),
                                       andCollectionView: self.moviesCollectionView)
            } else {
                moviesCollectionView.backgroundView?.isHidden = true
            }
            return filteredMovies.count
        } else {
            if internetProblem {
                setBackgroundErrorView(withText: "Um erro ocorreu. Por favor, tente novamente.",
                                       image: UIImage(named: "no_connection_icon"),
                                       andCollectionView: self.moviesCollectionView)
            } else {
                moviesCollectionView.backgroundView?.isHidden = true
            }
            return movies.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
        guard let cell = moviesCollectionView
            .dequeueReusableCell(withReuseIdentifier: "MoviesCollectionsCell", for: indexPath) as? MoviesCollectionCell
            else { return UICollectionViewCell() }
        
            if isSearchActive {
                cell.movieItem = filteredMovies[indexPath.row]
                cell.prepare()
            } else {
                cell.movieItem = movies[indexPath.row]
                cell.prepare()
            }
            //To work favorite button
            cell.delegate = self
        return cell
    }
}

