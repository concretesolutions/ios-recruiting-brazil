//
//  MovieGridViewController+UICollectionViewDelegate.swift
//  Mov
//
//  Created by Miguel Nery on 30/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

extension MovieGridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = self.interactor?.movie(at: indexPath.row) else { return }
        
        self.navigateToDetailsView(of: selectedMovie)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.contentSize.height - scrollView.frame.size.height
        if (scrollView.contentOffset.y == height) {
            self.incrementPage()
        }
    }
}
