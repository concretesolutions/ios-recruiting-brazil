//
//  MovieCollectionCell.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    lazy var bannerImageView: UIImageView = UIImageView()
    
    lazy var titleLabel: UILabel = UILabel()
    
    lazy var favoriteButton: UIButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieCollectionCell {
    
    func addViews() {
        self.addSubviews([self.bannerImageView,
                        self.titleLabel,
                        self.favoriteButton])
    }
    
    func setupLayout() {
        self.addViews()
        
        NSLayoutConstraint.activate([
            bannerImageView.topAnchor.constraint(equalTo: self.topAnchor),
            bannerImageView.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
    
}
