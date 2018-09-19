//
//  PopularMoviesView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class PopularMoviesView: UIView {
    
    /// The collectionView which holds the movies
    let collectionView:UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .appColorDarker
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    /// The RefreshControl that indicates when the list is updating
    let refreshControl:UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        return refreshControl
    }()

    // Adds the constraints to this view
    private func setupConstraints(){
        self.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
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
