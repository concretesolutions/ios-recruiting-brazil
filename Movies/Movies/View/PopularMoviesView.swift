//
//  PopularMoviesView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class PopularMoviesView: BaseView {
    
    /// The collectionView which holds the movies
    let collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .appSecondColor
        collectionView.alwaysBounceVertical = true
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    /// The RefreshControl that indicates when the list is updating
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .appColor
        return refreshControl
    }()

    // Adds the constraints to this view
    override func setupConstraints(){
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        super.setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
