//
//  MovieCollectionCell.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {
    
    private let posterImage = UIImageView()
    private var titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.posterImage)
        self.posterImage.image = UIImage(named: "stevenPoster")!
        self.posterImage.contentMode = .scaleAspectFill
        
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "Steven Universe"
        self.titleLabel.backgroundColor = UIColor(named: "darkBlue")
        self.titleLabel.textColor = UIColor(named: "yellow")
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        self.posterImage.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.posterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.posterImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.posterImage.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.backgroundColor = .yellow
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
