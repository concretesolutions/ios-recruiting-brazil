//
//  MovieGridCollectionView.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class MovieGridCollectionView: UICollectionView {
    
    static let reuseIdentifier = "MovieGridCollectionViewCell"
    
    private static var cellSize: CGSize {
        let width = CGFloat(150).proportionalToWidth
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    private static var flowLayout: UICollectionViewFlowLayout =  {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        flowLayout.itemSize = MovieGridCollectionView.cellSize
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 25, bottom: 10, right: 25)
        
        return flowLayout
    }()
    

    init() {
        super.init(frame: .zero, collectionViewLayout: MovieGridCollectionView.flowLayout)
        self.backgroundColor = .white
        self.register(MovieGridCollectionViewCell.self, forCellWithReuseIdentifier: MovieGridCollectionView.reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
