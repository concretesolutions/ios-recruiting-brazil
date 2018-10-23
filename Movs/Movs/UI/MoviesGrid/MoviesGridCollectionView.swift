//
//  MoviesGridCollectionView.swift
//  Movs
//
//  Created by Gabriel Reynoso on 23/10/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import UIKit

// MARK: - Collection view

final class MoviesGridCollectionView: UICollectionView, ViewCode {
    
    private(set) var layout: MoviesGridLayout? {
        didSet {
            self.delegate = self.layout
        }
    }
    
    func design() {
        self.register(MoviesGridCell.self, forCellWithReuseIdentifier: MoviesGridCell.identifier)
        self.layout = MoviesGridLayout()
        self.backgroundColor = .clear
    }
    
    func autolayout() {
    }
}

// MARK: - Collection view layout delegate

final class MoviesGridLayout: NSObject, UICollectionViewDelegateFlowLayout {
    
    private static let numberOfItemsPerLine:Int = 2
    
    private static let lineSpacing:CGFloat = 20.0
    private static let itemSpacing:CGFloat = 15.0
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalWhiteSpace = CGFloat(MoviesGridLayout.numberOfItemsPerLine + 1) * MoviesGridLayout.itemSpacing
        let horizontalCellSpace = collectionView.bounds.width - horizontalWhiteSpace
        let itemWitdh = horizontalCellSpace/CGFloat(MoviesGridLayout.numberOfItemsPerLine)
        return CGSize(width: itemWitdh, height: 200.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return MoviesGridLayout.lineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return MoviesGridLayout.itemSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: MoviesGridLayout.lineSpacing,
                            left: MoviesGridLayout.itemSpacing,
                            bottom: MoviesGridLayout.lineSpacing,
                            right: MoviesGridLayout.itemSpacing)
    }
}
