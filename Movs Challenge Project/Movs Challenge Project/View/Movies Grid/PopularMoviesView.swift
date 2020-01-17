//
//  PopularMoviesView.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class PopularMoviesView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    let collectionViewFlowLayout = UICollectionViewFlowLayout()
    
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    // Private Types
    // Private Properties
    // Private Methods
    
    private func renderSuperView() {
        sv(
            collectionView
        )
    }
    
    private func renderLayout() {
        collectionView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        collectionView.Bottom == safeAreaLayoutGuide.Bottom
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
        collectionView.style { (s) in
            s.backgroundColor = .clear
            s.collectionViewLayout = collectionViewFlowLayout
        }
        
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumInteritemSpacing = 16
        collectionViewFlowLayout.estimatedItemSize = CGSize(width: 120, height: 120)
        collectionViewFlowLayout.minimumLineSpacing = 16
        collectionViewFlowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
