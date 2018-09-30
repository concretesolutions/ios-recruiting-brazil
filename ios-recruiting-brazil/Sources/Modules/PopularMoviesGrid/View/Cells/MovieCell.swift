//
//  MovieCell.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    private lazy var img: UIImageView = {
        let img = UIImageView(frame: .zero)
        return img
    }()
    
    private lazy var lbMovieName: UILabel = {
        let label = UILabel()
        label.text = "name"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var btFavorite: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        button.addTarget(self, action: #selector(favoriteAction), for: .touchUpInside)
        return button
    }()
    
    
    @objc func favoriteAction() {
        print("favorite")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewConfiguration()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieCell: ViewConfiguration {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.img)
        self.contentView.addSubview(self.lbMovieName)
        self.contentView.addSubview(self.btFavorite)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.img.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.img.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.img.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.lbMovieName.heightAnchor.constraint(equalToConstant: 40.0),
            self.lbMovieName.topAnchor.constraint(equalTo: self.img.bottomAnchor),
            self.lbMovieName.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            self.lbMovieName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.btFavorite.heightAnchor.constraint(equalToConstant: 40.0),
            self.btFavorite.widthAnchor.constraint(equalToConstant: 40.0),
            self.btFavorite.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            self.btFavorite.topAnchor.constraint(equalTo: self.img.bottomAnchor)
        ])
    }
}
