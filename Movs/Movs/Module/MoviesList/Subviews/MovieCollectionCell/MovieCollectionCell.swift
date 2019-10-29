//
//  MovieCollectionCell.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    private let posterImgView = UIImageView()
    private var titleLabel = UILabel()
    private var loadingIndicator = UIActivityIndicatorView(style: .medium)
    private lazy var favoriteIconView: UIImageView = {
        let image = UIImage(systemName: "heart.fill")
        let imgView = UIImageView(image: image)
        imgView.tintColor = UIColor.appYellow
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        imgView.layer.shadowColor = UIColor.black.cgColor
        imgView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imgView.layer.shadowOpacity = 0.7
        imgView.layer.shadowRadius = 2
        imgView.clipsToBounds = false
        
        return imgView
    }()
    
    var viewModel: MovieCellViewModel? {
        didSet {
            self.titleLabel.text = viewModel!.titleText
            
            self.favoriteIconView.alpha = self.viewModel!.isFavorite ? 1 : 0
            
            self.viewModel!.fetchPoster { posterImg in
                self.posterImgView.image = posterImg
                
                self.posterImgView.alpha = 0.0
                UIView.animate(withDuration: 0.5) {
                    self.loadingIndicator.stopAnimating()
                    self.posterImgView.alpha = 1.0
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.posterImgView)
        self.posterImgView.contentMode = .scaleAspectFill
        self.posterImgView.clipsToBounds = true
        
        self.addSubview(self.titleLabel)
        self.titleLabel.textColor = UIColor.appYellow
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        self.addSubview(self.loadingIndicator)
        self.loadingIndicator.color = UIColor.white
        self.loadingIndicator.startAnimating()
        
        self.addSubview(self.favoriteIconView)
        self.bringSubviewToFront(self.favoriteIconView)
        
        UIView.translatesAutoresizingMaskIntoConstraintsToFalse(to: [self, self.posterImgView, self.titleLabel, self.loadingIndicator])
        NSLayoutConstraint.activate([
            self.posterImgView.topAnchor.constraint(equalTo: self.topAnchor),
            self.posterImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.posterImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.posterImgView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.loadingIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.loadingIndicator.topAnchor.constraint(equalTo: self.topAnchor),
            self.loadingIndicator.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            
            self.favoriteIconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.favoriteIconView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.favoriteIconView.heightAnchor.constraint(equalToConstant: 30),
            self.favoriteIconView.widthAnchor.constraint(equalToConstant: 30),
        ])
        
        self.backgroundColor = UIColor.appDarkBlue
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
