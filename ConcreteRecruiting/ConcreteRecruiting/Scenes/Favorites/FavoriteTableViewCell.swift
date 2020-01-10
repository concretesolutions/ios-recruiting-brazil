//
//  FavoriteTableViewCell.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 09/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension FavoriteTableViewCell {
    
    func addViews() {
        self.contentView.addSubviews([
            posterImageView,
            titleLabel,
            descriptionLabel,
            yearLabel
        ])
    }
    
    func setupLayout() {
        
        addViews()
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            posterImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.3),
            posterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: yearLabel.leadingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            yearLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 24),
            yearLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            yearLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.2),
            yearLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        ])
        
    }
    
}
