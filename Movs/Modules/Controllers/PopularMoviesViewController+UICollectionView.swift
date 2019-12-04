//
//  PopularMoviesViewController+UICollectionView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDataSource

extension PopularMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath) as? MovieHomeCollectionViewCell else {
            fatalError("Failed to dequeue movies cell as MovieHomeCollectionViewCell")
        }
        
        cell.viewModel = self.viewModel.viewModelForCellAt(indexPath: indexPath)
        cell.poster.image = UIImage.from(color: UIColor.secondarySystemBackground)
        return cell
    }
}
    
// MARK: - UICollectionViewDelegateFlowLayout

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSpacing: CGFloat = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.section)
        let heightSpacing: CGFloat = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        
        let insets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        let width: CGFloat = (collectionView.frame.width/3.0) - widthSpacing
        let height: CGFloat = (collectionView.frame.height/2.75) - heightSpacing
        
        return CGSize(width: width - insets.left, height: height - insets.top)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24.0, left: 8.0, bottom: 24.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

// MARK: - UICollectionViewDataSourcePrefetching

extension PopularMoviesViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        let rows = indexPaths.filter({ $0.row >= self.viewModel.numberOfMovies - 1 })
        if !rows.isEmpty && self.viewModel.shouldFetchMovies() {
            self.viewModel.fetchPopularMovies()
        }
    }
}
