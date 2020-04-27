//
//  MovieDetailsTrailerCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 27/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class MovieDetailsTrailerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var trailerImageView: UIImageView!
    
    var isHeightCalculated: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        // Initialization code
        self.layer.addBorder(edge: .bottom, color: UIColor.black.withAlphaComponent(0.1), thickness: 1)
    }

    func setup(with movieDetails: MovieDetails) {
        titleLabel.text = "Trailer"
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        //Exhibit A - We need to cache our calculation to prevent a crash.
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceilf(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        return layoutAttributes
    }
}
