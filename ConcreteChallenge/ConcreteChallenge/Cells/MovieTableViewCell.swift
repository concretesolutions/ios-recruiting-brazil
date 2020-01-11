//
//  MovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
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
        contentView.addSubview(posterView)
        
        posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        posterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        posterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

}
