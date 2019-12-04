//
//  MovieHomeCollectionViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

class MovieHomeCollectionViewCell: UICollectionViewCell {

    // MARK: - Interface Elements
    
    internal lazy var poster: UIImageView = {
        let poster = UIImageView(frame: .zero)
        poster.layer.cornerRadius = 4.0
        poster.layer.masksToBounds = true
        return poster
    }()
    
    internal lazy var favoriteButton: FavoriteButton = {
        let button = FavoriteButton(frame: .zero)
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.layer.cornerRadius = 12.0
        button.layer.masksToBounds = true
        return button
    }()
    
    // MARK: - Initializers and Deinitializers
        
    override required init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieHomeCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.poster)
        self.contentView.addSubview(self.favoriteButton)
    }
    
    func setupConstraints() {
        self.poster.snp.makeConstraints({ make in
            make.centerX.centerY.equalTo(self)
            make.width.height.equalTo(self)
        })
        
        self.favoriteButton.snp.makeConstraints({ make in
            make.width.height.equalTo(24.0)
            make.bottom.trailing.equalTo(-8.0)
        })
    }
}
