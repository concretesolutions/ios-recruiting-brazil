//
//  MoviesCollectionDelegate.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

class MoviesCollectionDelegate: NSObject, UICollectionViewDelegate{
    
    weak var delegate:MovieSelectionDelegate?
    var movies:[Movie]
    
    init(movies:[Movie], delegate:MovieSelectionDelegate?){
        self.movies = movies
        self.delegate = delegate
    }
    
}

extension MoviesCollectionDelegate: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing:CGFloat = AppearanceManager.collectionViewSpacing
        let numberOfItemsPerRow:CGFloat = 2
        let totalSpacing:CGFloat = (numberOfItemsPerRow + 1) * spacing
        let cellWidth = (collectionView.frame.width - totalSpacing)/numberOfItemsPerRow
        
        return MovieCollectionViewCell.size(forWidth: cellWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.movies[indexPath.item]
        self.delegate?.didSelect(movie: movie)
    }
    
    
    
}
