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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(named: "MainYellow")
        
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Favorite-gray"), for: .normal)
        
        return button
    }()
    
    var isFavorite: Bool = false {
        didSet {
            
            var imageName = "Favorite-gray"
            
            if self.isFavorite {
                imageName = "Favorite-filled"
            }
            
            self.favoriteButton.setImage(UIImage(named: imageName), for: .normal)
            
        }
    }
    
    func setup(with model: Movie) {
        
        // TODO: Download image
        
        self.titleLabel.text = model.title
        self.isFavorite = model.isFavorite
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(named: "CellBlue")

        self.setupLayout()
        
        self.favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapFavorite() {
        self.isFavorite = !self.isFavorite
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
            bannerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
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
