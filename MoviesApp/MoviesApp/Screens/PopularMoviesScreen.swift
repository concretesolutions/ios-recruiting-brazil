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
    
//    lazy var searchBar:UISearchBar = {
//        let bar = UISearchBar()
//        bar.placeholder = "Search for Movies..."
//        bar.translatesAutoresizingMaskIntoConstraints = false
//        return bar
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(searchController:UISearchController){
        searchController.searchBar.tintColor = Palette.blue
        searchController.searchBar.returnKeyType = .search
        searchController.searchBar.placeholder = "Search for Movies..."
    }
    
}

extension PopularMoviesScreen: ViewCode{
    
    func setupViewHierarchy() {
//        self.addSubview(searchBar)
        self.addSubview(collectionView)
        
    }
    
    func setupConstraints() {
//        searchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 44).isActive = true
//        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        searchBar.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        collectionView.backgroundColor = Palette.white
    }
    
    
}
