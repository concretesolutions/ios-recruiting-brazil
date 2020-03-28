//
//  HomeFavoriteItemCell.swift
//  FavoriteMovsFeature
//
//  Created by Marcos Felipe Souza on 26/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import UIKit
import AssertModule

struct FavoriteItemCellModel {
    var title: String?
    var image: UIImage?
    var year: String?
    var overview: String?
}

class HomeFavoriteItemCell: UITableViewCell {
    static let reuseCell = "HomeFavoriteItemCell"
    
    var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    var imageMovieImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var titleMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontAssets.avenirTextTitle
        return label
    }()
    
    var yearMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontAssets.avenirTextCell
        return label
    }()
    
    var overviewMovieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = FontAssets.avenirTextSubtitle
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
}

//MARK: - LifeCycle
extension HomeFavoriteItemCell {
    
    override func didMoveToSuperview() {
        self.setupView()
        self.setupConstraints()
        self.containerView.layer.cornerRadius = self.contentView.frame.height / 5
        self.containerView.layer.masksToBounds = true
        
        self.imageMovieImageView.clipsToBounds = true
        self.imageMovieImageView.layer.cornerRadius = 20
        self.imageMovieImageView.layer.masksToBounds = true
        
    }
}

//MARK: - setup UI
extension HomeFavoriteItemCell {
    
    func configCell(with cellItems: FavoriteItemCellModel) {
        
        if let image = cellItems.image {
            self.imageMovieImageView.image = image
        }
        
        self.yearMovieLabel.text = cellItems.year
        self.titleMovieLabel.text = cellItems.title
        self.overviewMovieLabel.text = cellItems.overview
    }
    
    private func setupView(){
        self.backgroundColor = Colors.whiteNormal
        self.containerView.addSubview(self.imageMovieImageView)
        self.containerView.addSubview(self.titleMovieLabel)
        self.containerView.addSubview(self.yearMovieLabel)
        self.containerView.addSubview(self.overviewMovieLabel)
        contentView.addSubview(self.containerView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            self.containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            self.containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            self.containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            
            self.imageMovieImageView.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 3),
            self.imageMovieImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 3),
            self.imageMovieImageView.widthAnchor.constraint(equalToConstant: 80),
            self.imageMovieImageView.heightAnchor.constraint(equalToConstant: 120),
            self.imageMovieImageView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -3),
            
            self.titleMovieLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 3),
            self.titleMovieLabel.leadingAnchor.constraint(equalTo: self.imageMovieImageView.trailingAnchor, constant: 8),
            
            self.yearMovieLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 3),
            self.yearMovieLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -5),
            
            self.overviewMovieLabel.topAnchor.constraint(equalTo: self.titleMovieLabel.bottomAnchor, constant: 3),
            self.overviewMovieLabel.leadingAnchor.constraint(equalTo: self.imageMovieImageView.trailingAnchor, constant: 5),
            self.overviewMovieLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -3),
            self.overviewMovieLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -3),
        ])
    }
}
