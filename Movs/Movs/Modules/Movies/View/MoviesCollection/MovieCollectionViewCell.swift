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
    @IBOutlet weak var outletFavorite: UIButton!
    
    func awakeFromNib(title: String) {
        super.awakeFromNib()
        self.outletMovieTitle.text = title
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        //self.outletMovieImage.image = nil
        self.outletActivityIndicator.startAnimating()
        if let image = imageURL {
            self.setup(imageURL: image)
        }
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
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        
        let imageFull = UIImage.init(named: "favorite_full_icon")
        let imageGray = UIImage.init(named: "favorite_gray_icon")
    
        if self.outletFavorite.currentImage == imageFull {
            // FIXME: - Chamar presenter para REMOVER do ADD
            self.outletFavorite.setImage(imageGray, for: .normal)
        }else if self.outletFavorite.currentImage == imageGray {
            // FIXME: - Chamar presenter para ADD
            self.outletFavorite.setImage(imageFull, for: .normal)
        }
        
    }
    
}
