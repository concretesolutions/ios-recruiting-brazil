//
//  MovieCollectionViewCell.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var safeArea:UILayoutGuide!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        safeArea = layoutMarginsGuide
//        setUpCellConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
