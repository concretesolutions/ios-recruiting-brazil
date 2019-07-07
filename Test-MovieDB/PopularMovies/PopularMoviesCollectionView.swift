//
//  PopularMoviesCollectionView.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class PopularMoviesCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupCell()
    }
    
    override func awakeFromNib() {
        
    }
    
    func setupCell() {
        self.register(PopularMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "popular")
        self.register(UINib(nibName: "PopularMoviesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "popular")
    }

}
