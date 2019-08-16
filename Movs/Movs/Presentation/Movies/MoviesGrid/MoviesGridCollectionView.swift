//
//  MoviesGridCollectionView.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Foundation
import UIKit

class MoviesGridCollectionView: UICollectionView {

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = Design.Insets.moviesGridCollection

        super.init(frame: frame, collectionViewLayout: layout)
        self.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
