//
//  MoviesCollectionViewDelegate.swift
//  Movies
//
//  Created by Renan Germano on 20/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesCVDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private var presenter: MoviesPresentation
    
    // MARK: - Initializers
    
    init(presenter: MoviesPresentation) {
        self.presenter = presenter
    }
    
    // MARK: - UICollectionViewDelegate protocol functions
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movieCell = collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell {
            self.presenter.didSelect(movie: movieCell.movie)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let cellWidth = (width/2)-5-4
        return CGSize(width: cellWidth, height: cellWidth*1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
    }
    
}
