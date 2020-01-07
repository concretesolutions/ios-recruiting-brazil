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
    
    var viewModel: MovieCellViewModel!
    
    func setup(with viewModel: MovieCellViewModel) {
        
        self.viewModel = viewModel
        
        self.titleLabel.text = viewModel.movieTitle
        self.bannerImageView.image = UIImage(data: viewModel.bannerData)
        self.isFavorite = viewModel.isFavorite
        
        self.viewModel.didAcquireBannerData = { [weak self] (data) in
            DispatchQueue.main.async {
                self?.bannerImageView.image = UIImage(data: data)
            }
        }
        
        self.viewModel.acquireBannerData()
        
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
        viewModel.didTapFavorite()
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
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1),
            favoriteButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])
        
    }
    
}
