//
//  MoviesCollectionViewController.swift
//  Movs
//
//  Created by Henrique Campos de Freitas on 08/08/19.
//  Copyright © 2019 Henrique Campos de Freitas. All rights reserved.
//

import UIKit

protocol MovieCollectionViewLayoutListener {
    func onCollectionViewLayoutUpdate(cellWidth: CGFloat)
}

class MoviesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let maxCellsPerRow : CGFloat = 4.0
    private let cellMinWidth: CGFloat = 160.0
    private let minCellSpacing: CGFloat = 10.0
    private let cellSpacingPercent: CGFloat = 0.06
    
    private var movieCellWidth: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        self.collectionView.collectionViewLayout = layout
        self.updateLayout(layout)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let collectionViewLayout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            self.updateLayout(collectionViewLayout)
        }
    }
    
    func updateLayout(_ layout: UICollectionViewFlowLayout) {
        let collectionViewWidth = self.collectionView.frame.width
        let cellsPerRow = min(maxCellsPerRow, floor((collectionViewWidth - minCellSpacing) / (cellMinWidth + minCellSpacing)))
        let fullCellWidth = collectionViewWidth / cellsPerRow
        
        let cellSpacing = max(minCellSpacing, (fullCellWidth * cellSpacingPercent))
        let totalSpacing = cellSpacing * (cellsPerRow + 1.0)
        let spacingPerCell = totalSpacing / cellsPerRow
        
        self.movieCellWidth = fullCellWidth - spacingPerCell
        
        layout.sectionInset = UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        
        for cell in self.collectionView.visibleCells {
            if let movieCell = cell as? MovieCollectionViewCell {
                movieCell.onCollectionViewLayoutUpdate(cellWidth: self.movieCellWidth)
            }
        }
    }
}

//DelegateFlowLayout
extension MoviesCollectionViewController {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.movieCellWidth, height: self.movieCellWidth)
    }
}

// DataSource
extension MoviesCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let movieCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        movieCell.favorite.image = [UIImage(named: "Favorite"), UIImage(named: "Favorite"), UIImage(named: "FavoriteFilled")].randomElement() as! UIImage
        movieCell.cover.backgroundColor = [UIColor.green, UIColor.red, UIColor.blue, UIColor.gray].randomElement()
        return movieCell
    }
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
