//
//  PopularMoviesCollectionView.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit

class PopularMoviesCollectionView: UICollectionView {
    
    override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout) {
        let aLayout = UICollectionViewFlowLayout()
        aLayout.sectionInset = Design.insets.popularMoviesCollectionView
        
        super.init(frame: frame, collectionViewLayout: aLayout)
        
        setupDesing()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDesing() {
        backgroundColor = Design.colors.white
    }
    
}
