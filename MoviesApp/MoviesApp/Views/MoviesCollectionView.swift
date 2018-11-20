//
//  MoviesCollectionView.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class MoviesCollectionView: UICollectionView {
    
    fileprivate var customDataSource:MoviesDataSource?
    fileprivate var customDelegate:MoviesCollectionDelegate?
    
    convenience init() {
        self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        customDelegate = MoviesCollectionDelegate(movies: [], delegate: nil)
        customDataSource = MoviesDataSource(movies: [], collectionView: self, delegate: customDelegate!)
        setupLayout()
    }
    
    func setupLayout(){
        let spacing:CGFloat = AppearanceManager.collectionViewSpacing
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        self.collectionViewLayout = layout
    }
    
    func setupCollectionView(with movies:[Movie], selectionDelegate:MovieSelectionDelegate){
        self.customDelegate = MoviesCollectionDelegate(movies: movies, delegate: selectionDelegate)
        self.customDataSource = MoviesDataSource(movies: movies, collectionView: self, delegate: customDelegate!)
    }
    
    func searchFor(text:String){
        
    }

}
