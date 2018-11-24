//
//  FavoriteMovieCell.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 15/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoriteMovieCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var outletMovieImage: UIImageView!
    @IBOutlet weak var outletMovieTitle: UILabel!
    @IBOutlet weak var outletMovieYear: UILabel!
    @IBOutlet weak var outletMovieOverview: UILabel!
    @IBOutlet weak var outletActivityIndicator: UIActivityIndicatorView!
    
    var imageURL: String?
    
    func awakeFromNib(title: String, year: String, overview: String) {
        super.awakeFromNib()
        // Initialization code
        
        //self.outletMovieImage.image
        self.outletMovieTitle.text = title
        self.outletMovieYear.text = year
        self.outletMovieOverview.text = overview
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Setups
    
    func setup(imageURL: String) {
        // Cell Reference
        self.imageURL = imageURL
        if let url = self.imageURL {
            self.outletMovieImage.loadImage(imageURL: url) { (uiImage) in
                if let image = uiImage {
                    self.outletMovieImage.image = image
                }
                self.outletActivityIndicator.stopAnimating()
            }
        }else{
            self.outletMovieImage.image = nil // ServerManager.moviePlaceholder
            self.outletActivityIndicator.stopAnimating()
        }
        
    }

}
