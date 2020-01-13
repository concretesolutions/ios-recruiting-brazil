//
//  DetailTableViewCell.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "Favorite-gray"), for: .normal)
        button.isHidden = true
        
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
    
    var viewModel: MovieDetailViewModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with section: Section, viewModel: MovieDetailViewModel) {
        
        switch section {
        case .image(let data):
            self.posterImageView.image = UIImage(data: data)
            
        case .text(let text):
            self.label.text = text
            
        case .textWithButton(let text):
            self.label.text = text
            self.favoriteButton.isHidden = false
            self.isFavorite = viewModel.isFavorite
            self.viewModel = viewModel
            self.favoriteButton.addTarget(self, action: #selector(didTapFavorite), for: .touchUpInside)
            
            self.viewModel?.didChangeFavoriteState = { [weak self] (isFavorite) in
                self?.isFavorite = isFavorite
            }
            
        }
        
    }
    
    @objc private func didTapFavorite() {
        self.viewModel?.didTapFavorite()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension DetailTableViewCell {
    
    func addViews() {
        self.contentView.addSubviews([label, favoriteButton, posterImageView])
    }
    
    func setupLayout() {
        
        addViews()
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            label.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            label.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            posterImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            favoriteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8),
            favoriteButton.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5)
        ])
        
    }
    
}
