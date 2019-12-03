//
//  MovieHomeCollectionViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class MovieHomeCollectionViewCell: UICollectionViewCell {

    internal var coverImage: UIImageView
    internal var favoriteButton: UIButton
        
    override required init(frame: CGRect) {
        self.coverImage = UIImageView(frame: .zero)
        self.favoriteButton = UIButton(frame: .zero)
        super.init(frame: frame)

        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieHomeCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.coverImage)
        self.contentView.addSubview(self.favoriteButton)
    }
    
    func setupConstraints() {
        self.coverImage.snp.makeConstraints({ make in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(self)
        })
        
        self.favoriteButton.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
            make.bottom.trailing.equalTo(-8.0)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.coverImage.layer.cornerRadius = 4.0
        self.coverImage.layer.masksToBounds = true
        self.favoriteButton.backgroundColor = .white
        self.favoriteButton.tintColor = .red
        self.favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
        self.favoriteButton.imageEdgeInsets = UIEdgeInsets(top: 5.0, left: 3.0, bottom: 5.0, right: 5.0)
        self.favoriteButton.layer.cornerRadius = 12.0
        self.favoriteButton.layer.masksToBounds = true
    }
}
