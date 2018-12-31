//
//  MoviesGridCollectionDelegate.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit
import Reusable

final class MoviesGridCollectionDelegate: NSObject, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    var movies:[Movie]!
    let numberOfItems = 2
    let moviesDelegate: MoviesSelectionDelegate?
    
    init(movies: [Movie], delegate: MoviesSelectionDelegate){
        self.movies = movies
        self.moviesDelegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = CGFloat(numberOfItems)
        let width = (UIScreen.main.bounds.width - Design.Insets.moviesGridCollection.right * (items + 1)) / items
        return CGSize(width: width, height: width * 1.50)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoviesGridCollectionViewCell{
            movies[indexPath.row].poster = cell.imageView.image
        }
        moviesDelegate?.didSelectMovie(movie: movies[indexPath.row])
    }
    
    
}
