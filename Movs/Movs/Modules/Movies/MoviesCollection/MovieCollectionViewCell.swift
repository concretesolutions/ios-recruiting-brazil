//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    var imageURL: String?
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var outletMovieImage: UIImageView!
    @IBOutlet weak var outletMovieTitle: UILabel!
    
    func awakeFromNib(title: String) {
        super.awakeFromNib()
        self.outletMovieTitle.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.outletMovieImage.image = nil
        self.outletActivityIndicator.startAnimating()
        //self.setup(content: data)
    }
    
    func setup(imageURL: String) {
        // Cell Reference
        self.imageURL = imageURL
        self.outletMovieImage.loadMovieImage(urlString: imageURL, to: self) { (status) in
            if status {
                self.outletActivityIndicator.stopAnimating()
            }
        }
    }
    
}
