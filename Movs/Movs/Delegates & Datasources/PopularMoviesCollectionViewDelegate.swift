//
//  PopularMoviesCollectionViewFlowLayoutDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

protocol MovieSelectionDelegate {
    func didSelect(movie:Movie)
}

class PopularMoviesCollectionViewDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    var delegate: MovieSelectionDelegate?
    
    private let movies: [Movie]
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = Style.insets.popularMoviesCollectionView
    
    init(movies: [Movie], delegate: MovieSelectionDelegate) {
        self.movies = movies
        self.delegate = delegate
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie = movies[indexPath.row]
        //FIXME: movie.thumbnail = placeholder image
        if let cell = collectionView.cellForItem(at: indexPath) as? PopularMoviesCollectionViewCell {
            movie.thumbnail = cell.imageView.image
        }
        delegate?.didSelect(movie: movie)
    }
    
}
