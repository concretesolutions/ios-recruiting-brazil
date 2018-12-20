//
//  MoviesGridCollectionView.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit

class MoviesGridCollectionView: UICollectionView{
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Design.Insets.moviesGridCollection
        
        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
