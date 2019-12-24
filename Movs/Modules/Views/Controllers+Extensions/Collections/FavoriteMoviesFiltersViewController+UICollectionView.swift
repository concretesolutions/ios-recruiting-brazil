//
//  FavoriteMoviesFiltersViewController+UICollectionView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 21/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegate

extension FavoriteMoviesFiltersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GenreCollectionViewCell, let genreName = cell.nameLabel.text else {
            return
        }
        
        if self.selectedGenres.contains(genreName) {
            self.selectedGenres.remove(genreName)
            UIView.transition(with: cell.contentView, duration: 0.15, options: .transitionCrossDissolve, animations: {
                cell.contentView.backgroundColor = UIColor.systemGray3
            })
        } else {
            self.selectedGenres.insert(genreName)
            UIView.transition(with: cell.contentView, duration: 0.15, options: .transitionCrossDissolve, animations: {
                cell.contentView.backgroundColor = UIColor(named: "palettePurple")
            })
        }
    }
}

// MARK: - UICollectionViewDataSource

extension FavoriteMoviesFiltersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfGenres
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as? GenreCollectionViewCell else {
            fatalError()
        }
        
        cell.nameLabel.text = self.viewModel.genreNameForItemAt(indexPath: indexPath)
        if !self.selectedGenres.contains(cell.nameLabel.text!) {
            cell.contentView.backgroundColor = UIColor.systemGray3
        } else {
            cell.contentView.backgroundColor = UIColor(named: "palettePurple")
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteMoviesFiltersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = self.viewModel.sizeForItemAt(indexPath: indexPath)
        return CGSize(width: size.width + 24.0, height: size.height + 8.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
    }
}
