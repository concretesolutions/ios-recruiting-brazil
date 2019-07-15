//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit
import SnapKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView = UIImageView()
    var favoriteButton: UIButton = UIButton()
    var titleLabel: UILabel = UILabel()
    
    
    
    var viewModel: MovieCollectionViewCellViewModel? {
        didSet {
            guard let viewModel = self.viewModel else {
                return
            }
            viewModel.delegate = self
            viewModel.setupComponents()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupVisualComponents()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupVisualComponents() {
        self.addSubview(self.imageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.favoriteButton)

        
        self.backgroundView = UIView(frame: .zero)
        self.backgroundView?.backgroundColor = ApplicationColors.blue.uiColor
        self.backgroundView?.snp.makeConstraints({ (make) in
            make.top.left.right.bottom.equalTo(self.contentView).inset(5)
        })
        
        imageView.contentMode = .scaleAspectFit
        
        self.imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.backgroundView!).inset(5)
            make.height.equalTo(self.imageView.snp.width).multipliedBy(0.6)
        }
        
        self.titleLabel.numberOfLines = 0
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.titleLabel.minimumScaleFactor = 0.5
        self.titleLabel.textColor = .white
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom)
            make.left.equalTo(self.imageView).offset(10)
            make.bottom.equalTo(self.backgroundView!)
            make.right.equalTo(self.favoriteButton.snp.left).offset(-10)

        }
        
        self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .highlighted)
        self.favoriteButton.addTarget(self, action: #selector(self.didTapInFavoriteButton), for: .touchUpInside)
        self.favoriteButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageView.snp.bottom)
            make.bottom.equalTo(self.backgroundView!)
            make.right.equalTo(self.imageView).offset(-10)
            make.width.equalTo(30)
        }
        
    }
    
    @objc func didTapInFavoriteButton() {
        self.viewModel?.handleFavoriteAction()
    }
    
}


extension MovieCollectionViewCell: MovieCollectionViewCellDelegate {
    func setupCell() {
        if let viewModel = self.viewModel {
            self.imageView.image = viewModel.image
            self.favoriteButton.isHighlighted = viewModel.isFavorited
            self.titleLabel.text = viewModel.name
        }
        
    }
    
    func updateUIFavoriteState() {
        if let viewModel = self.viewModel {
            DispatchQueue.main.async {
                self.favoriteButton.isHighlighted = viewModel.isFavorited
            }
        }

    }
}
