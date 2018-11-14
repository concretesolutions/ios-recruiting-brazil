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
    var favorite: Bool = false {
        didSet {
            self.updateFavoriteIcon(status: favorite)
        }
    }
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var outletMovieImage: UIImageView!
    @IBOutlet weak var outletMovieTitle: UILabel!
    @IBOutlet weak var outletFavorite: UIButton!
    
    // MARK: - Setups
    
    func awakeFromNib(title: String, favorite: Bool) {
        super.awakeFromNib()
        self.outletMovieTitle.text = title
        self.favorite = favorite
    }
    
    func setup(imageURL: String) {
        // Cell Reference
        self.imageURL = imageURL
        if let url = self.imageURL {
            self.outletMovieImage.loadMovieImage(urlString: url, to: self) { (status) in
                if status {
                    self.outletActivityIndicator.stopAnimating()
                }
            }
        }else{
            self.outletMovieImage.image = nil // ServerManager.moviePlaceholder
        }
        
    }
    
    // MARK: - Favorite Functions
    
    func updateFavoriteIcon(status: Bool) {
        if status {
            // FIXME: - Chamar presenter para REMOVER do ADD
            let imageFull = UIImage.init(named: "favorite_full_icon")
            self.outletFavorite.setImage(imageFull, for: .normal)
        }else{
            // FIXME: - Chamar presenter para ADD
            let imageGray = UIImage.init(named: "favorite_gray_icon")
            self.outletFavorite.setImage(imageGray, for: .normal)
        }
    }

    // MARK: - Reuse
    // FIXME: - Reusable Favorite Icon
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.outletMovieImage.image = nil // ServerManager.moviePlaceholder
        self.outletActivityIndicator.startAnimating()
        if let image = imageURL {
            self.setup(imageURL: image)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func actionFavorite(_ sender: UIButton) {
        self.favorite = !self.favorite
    }
    
}
