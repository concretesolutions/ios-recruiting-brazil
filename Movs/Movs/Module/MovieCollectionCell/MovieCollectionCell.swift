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
    
    var viewModel: MovieCellViewModel? {
        didSet {
            self.titleLabel.text = viewModel!.titleText
            viewModel!.fetchPoster { posterImg in
                self.posterImgView.image = posterImg
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.posterImgView)
        self.posterImgView.contentMode = .scaleAspectFill
        
        self.addSubview(self.titleLabel)
        self.titleLabel.backgroundColor = UIColor(named: "darkBlue")
        self.titleLabel.textColor = UIColor(named: "yellow")
        self.titleLabel.textAlignment = .center
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        
        
        self.posterImgView.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.posterImgView.topAnchor.constraint(equalTo: self.topAnchor),
            self.posterImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.posterImgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.posterImgView.bottomAnchor.constraint(equalTo: self.titleLabel.topAnchor),
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
