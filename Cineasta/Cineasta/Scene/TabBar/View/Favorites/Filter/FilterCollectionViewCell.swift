//
//  FilterCollectionViewCell.swift
//  Cineasta
//
//  Created by Tomaz Correa on 05/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var genreNameLabel: UILabel!
    
    // MARK: - VARIABLES -
    public var selectedGenre = false
}

// MARK: - AUTOMATIC SIZE -
extension FilterCollectionViewCell {
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
        layoutAttributes.size.height = size.height
        layoutAttributes.size.width = size.width
        return layoutAttributes
    }
}

// MARK: - AUX METHODS -
extension FilterCollectionViewCell {
    public func setupView() {
        self.selectedGenre ? self.setupGenreSelected() : self.setupGenreUnselected()
    }
    
    public func setupGenreSelected() {
        self.selectedGenre = true
        self.mainView.backgroundColor = .black
        self.genreNameLabel.backgroundColor = .black
        self.genreNameLabel.textColor = .white
    }
    
    public func setupGenreUnselected() {
        self.selectedGenre = false
        self.mainView.backgroundColor = .white
        self.genreNameLabel.backgroundColor = .white
        self.genreNameLabel.textColor = .black
    }
}
