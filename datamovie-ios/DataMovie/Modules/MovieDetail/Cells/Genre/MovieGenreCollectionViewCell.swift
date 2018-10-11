//
//  MovieGenreCollectionViewCell.swift
//  DataMovie
//
//  Created by Andre Souza on 20/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit

class MovieGenreCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var genreLbl: DMLabel!
    
    var genre: String? {
        didSet {
            genreLbl.text = genre
            genreLbl.sizeToFit()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        // Code below is needed to make the self-sizing cell work when building for iOS 12 from Xcode 10.0:
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }

}
