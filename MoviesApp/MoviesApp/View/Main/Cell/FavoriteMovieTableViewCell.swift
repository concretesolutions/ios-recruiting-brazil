//
//  FavoriteMovieTableViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backdropImageOutlet: UIImageView!
    @IBOutlet weak var movieTitleOutlet: UILabel!
    @IBOutlet weak var movieDescriptionOutlet: UILabel!
    @IBOutlet weak var movieYearOutlet: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(backdropImage: UIImage, title: String, detail:String, release:String){
        
        self.backdropImageOutlet.image = backdropImage
        self.movieTitleOutlet.text = title
        self.movieYearOutlet.text = release
        self.movieDescriptionOutlet.text = detail
        
    }

}
