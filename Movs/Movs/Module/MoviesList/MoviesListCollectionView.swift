//
//  MoviesListCollectionView.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MoviesListCollectionView: UICollectionView {

    static let MOVIE_CELL_IDENTIFIER = "movieCollectionCell"
    
    var cellSize: CGFloat {
        let totalWidth = (self.frame.width - 30)
        return totalWidth / 2
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        
        super.init(frame: .zero, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MoviesListCollectionView.MOVIE_CELL_IDENTIFIER)
        
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
