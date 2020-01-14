//
//  MovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    var posterView: PosterView? {
        didSet {
            setupPoster()
        }
    }
    
    override func prepareForReuse() {
        posterView?.removeFromSuperview()
        posterView = nil
    }
    
    func setupPoster() {
        guard let posterView = self.posterView else { return }
        
        posterView.translatesAutoresizingMaskIntoConstraints = false
        
        posterView.layer.shadowColor = UIColor.black.cgColor
        posterView.layer.shadowOpacity = 0.8
        posterView.layer.shadowOffset = .zero
        posterView.layer.shadowRadius = 3
        posterView.layer.shouldRasterize = true
        posterView.layer.rasterizationScale = UIScreen.main.scale
        
        contentView.addSubview(posterView)
        
        posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        posterView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }

}
