//
//  MovieListCellsManipulator.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 22/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

protocol MovieViewCell: UICollectionViewCell, MovieView {
    var movieImageView: UIImageView { get set }
}

struct MovieListPresentationManager {
    var modes: [MovieListPresentationMode]
    
    func dequeueCell(fromCollection collectionView: UICollectionView, indexPath: IndexPath, presentationMode: Int) -> MovieViewCell {
        guard presentationMode >= 0 && presentationMode < modes.count,
              let movieCell = collectionView.dequeueReusableCell(
                    forCellType: modes[presentationMode].cellType,
                    for: indexPath
              ) as? MovieViewCell else {
            fatalError("presentationMode is invalid, it must be between 0 and \(modes.count)")
        }
        
        return movieCell
    }
    
    func registerCells(atMoviesCollectionView moviesCollectionView: UICollectionView) {
        modes.forEach { (cellInfo) in
            moviesCollectionView.registerReusableCell(forCellType: cellInfo.cellType)
        }
    }
    
    func sizeForCell(presentationMode: Int, atCollectionView collectionView: UICollectionView) -> CGSize? {
        guard presentationMode >= 0 && presentationMode < modes.count else {
            fatalError()
        }
        let cellInfo = modes[presentationMode]
        
        let numberOfColumns = cellInfo.numberOfColumns
        let heightFactor = cellInfo.heightFactor
        
        guard let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return nil
        }
        let collectionViewHeight = collectionView.frame.height - collectionView.contentInset.top
        let floatingNumberOfColumns = CGFloat(numberOfColumns)
        let movieCellWidth = (collectionView.frame.width - floatingNumberOfColumns * collectionViewLayout.minimumInteritemSpacing)/floatingNumberOfColumns
        
        let movieCellHeight = movieCellWidth * heightFactor
        
        guard movieCellHeight < collectionViewHeight else {
            let adjustedCellHeight = collectionViewHeight
            let adjustedCellWidth = adjustedCellHeight / heightFactor
            
            return CGSize(width: adjustedCellWidth, height: adjustedCellHeight)
        }
        
        return CGSize(width: movieCellWidth, height: movieCellHeight)
    }
    
    var toggleButtonItems: [ToggleButtonItem] {
        return self.modes.map { (presentationMode) -> ToggleButtonItem in
            return ToggleButtonItem(image: presentationMode.iconImage)
        }
    }
}
