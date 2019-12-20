//
//  PopularMoviesViewController+UICollectionView.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - UICollectionViewDelegate

extension PopularMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.didSelectItemAt(indexPath: indexPath)
    }
}

// MARK: - UICollectionViewDataSource

extension PopularMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfPopularMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movies", for: indexPath) as? PopularMovieCollectionViewCell else {
            fatalError("Failed to dequeue movies cell as MovieHomeCollectionViewCell")
        }
        
        cell.viewModel = self.viewModel.cellViewModelForItemAt(indexPath: indexPath)
        cell.poster.backgroundColor = UIColor.secondarySystemBackground
        return cell
    }
}
    
// MARK: - UICollectionViewDelegateFlowLayout

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthSpacing: CGFloat = self.collectionView(collectionView, layout: collectionViewLayout, minimumLineSpacingForSectionAt: indexPath.section)
        let heightSpacing: CGFloat = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAt: indexPath.section)
        let insets: UIEdgeInsets = self.collectionView(collectionView, layout: collectionViewLayout, insetForSectionAt: indexPath.section)
        
        let width: CGFloat = (collectionView.bounds.width/3.0)
        let height: CGFloat = width * 1.755
        
        return CGSize(width: width - insets.left - widthSpacing, height: height - insets.top - heightSpacing)
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
        let rows = indexPaths.filter({ $0.row >= self.viewModel.numberOfPopularMovies - 3 })
        if !rows.isEmpty && self.viewModel.searchStatus == .none && self.viewModel.shouldFetchNextPage {
            self.viewModel.fetchNextPopularMoviesPage()
        }
    }
}
