//
//  PopularMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class PopularMoviesScreen: UIView {
    
    lazy var collectionView:MoviesCollectionView = {
        let view = MoviesCollectionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(with movies:[Movie], selectionDelegate:MovieSelectionDelegate){
        self.collectionView.setupCollectionView(with: movies, selectionDelegate: selectionDelegate)
    }

}

extension PopularMoviesScreen: ViewCode{
    
    func setupViewHierarchy() {
        self.addSubview(collectionView)
    }
    
    func setupConstraints() {
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        collectionView.backgroundColor = Palette.white
    }
    
    
}
