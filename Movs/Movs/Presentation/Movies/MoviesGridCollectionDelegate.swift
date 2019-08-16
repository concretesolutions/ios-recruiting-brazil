//
//  MoviesGridCollectionDelegate.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import Reusable
import UIKit

final class MoviesGridCollectionDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var movies: [Movie]!
    let numberOfItems = 2
    weak var moviesDelegate: MoviesSelectionDelegate?

    init(movies: [Movie], delegate: MoviesSelectionDelegate) {
        self.movies = movies
        self.moviesDelegate = delegate
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let items = CGFloat(numberOfItems)
        let width = (UIScreen.main.bounds.width - Design.Insets.moviesGridCollection.right * (items + 1)) / items
        return CGSize(width: width, height: width * 1.50)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoviesGridCollectionViewCell {
            movies[indexPath.row].poster = cell.imageView.image
        }
        moviesDelegate?.didSelectMovie(movie: movies[indexPath.row])
    }
}
