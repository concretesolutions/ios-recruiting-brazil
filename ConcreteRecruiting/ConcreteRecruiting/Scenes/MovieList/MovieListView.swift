//
//  MovieListView.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListView: UIView {
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero)
        
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        return collectionView
    }()
    
    lazy var errorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .red
        
        return view
    }()
    
    lazy var searchErrorView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
      override init(frame: CGRect) {
          super.init(frame: frame)
          
          self.setupLayout()
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

}

extension MovieListView {
    
    func addViews() {
        self.addSubviews([self.collectionView,
                        self.errorView,
                        self.searchErrorView,
                        self.activityIndicator])
    }
    
    func setupLayout() {
        self.addViews()
        
        NSLayoutConstraint.activate([
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
//
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8),
//            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
//        ])
//
//        NSLayoutConstraint.activate([
//            favoriteButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8),
//            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
//            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
//        ])
        
    }
    
}
