//
//  PopularMoviesCollectionViewFlowLayoutDelegate.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit

class PopularMoviesCollectionViewDelegateFlowLayout: NSObject, UICollectionViewDelegateFlowLayout {

    private let movies: [Movie]
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = Style.insets.popularMoviesCollectionView
    
    init(movies: [Movie]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = UIScreen.main.bounds.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem * 1.5)
    }
    
}
