//
//  MovieCollectionDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class MovieCollectionDelegate: NSObject, MovieData, UICollectionViewDelegateFlowLayout {
    
    weak var moviesDelegate: MoviesDelegate?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width
        //return MovieCollectionViewCell.size(for: width)
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //return MovieCollectionViewCell.lineSpacing
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moviesDelegate?.didSelectMovie(at: indexPath.item)
    }
}
