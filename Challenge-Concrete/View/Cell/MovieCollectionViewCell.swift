//
//  MovieCollectionViewCell.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit
import SmartConstraint

class MovieCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()
    let backgroundLabelView = UIView()
    let titleLabel = UILabel()
    
    var favoriteAction: (() -> Void)?
    var isFavorite: Bool = false
    lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        return button
    }()
    
    static var lineSpacing: CGFloat = 16
    
    static func size(for parentWidth: CGFloat) -> CGSize {
        let orientation = UIDevice.current.orientation
        let orientationIsLeftOrRight = orientation == .landscapeLeft || orientation == .landscapeRight
        let numberOfCells: CGFloat = orientationIsLeftOrRight ? 3 : 2
        let width = (parentWidth / numberOfCells) - (lineSpacing/2)
        let height = width * 1.6
        return CGSize(width: width, height: height)
    }
    
    func setupData(title: String?) {
        titleLabel.text = title
        setupView()
    }
    
    @objc func favoriteButtonTapped() {
        favoriteAction?()
        isFavorite = !isFavorite
        changeFavoriteIcon(isAdding: isFavorite)
    }
    
    func changeFavoriteIcon(isAdding: Bool) {
        let imageName: String = isAdding ? "favorite_full_icon" : "favorite_gray_icon"
        favoriteButton.setImage(UIImage(named: imageName), for: .normal)
        isFavorite = isAdding
    }
    
}

extension MovieCollectionViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubviews([imageView, backgroundLabelView])
        backgroundLabelView.addSubviews([titleLabel, favoriteButton])
    }
    
    func buildConstraints() {
        imageView.anchor
            .top(safeAreaLayoutGuide.topAnchor)
            .left(safeAreaLayoutGuide.leftAnchor)
            .right(safeAreaLayoutGuide.rightAnchor)
            .bottom(backgroundLabelView.topAnchor)
        
        backgroundLabelView.anchor
            .height(imageView.heightAnchor, multiplier: 0.2)
            .bottom(safeAreaLayoutGuide.bottomAnchor)
            .left(safeAreaLayoutGuide.leftAnchor)
            .right(safeAreaLayoutGuide.rightAnchor)
        
        titleLabel.anchor
            .left(backgroundLabelView.leftAnchor)
            .right(favoriteButton.leftAnchor)
            .centerY(backgroundLabelView.centerYAnchor)
        
        favoriteButton.anchor
            .right(backgroundLabelView.rightAnchor, padding: 8)
            .width(constant: 30)
            .height(constant: 30)
            .centerY(backgroundLabelView.centerYAnchor)
    }
    
    func setupAditionalConfiguration() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        backgroundLabelView.backgroundColor = .gray
        titleLabel.textAlignment = .center
        
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
}
