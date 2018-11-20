//
//  FavoriteMovieTableViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 11/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit
import Kingfisher

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
    
    func setupCell(title: String, detail:String, release:String, posterPath: String){
        
        let imageUrl = "https://image.tmdb.org/t/p/w200"
        let imageEndpoint = imageUrl + posterPath
        
        print(posterPath)
        print(imageEndpoint)
        
        let url = URL(string: imageEndpoint)
        
        self.backdropImageOutlet.kf.setImage(with: url)
        self.movieTitleOutlet.text = title
        
        var parts = release.components(separatedBy: "-")
        print(parts)
        
        self.movieYearOutlet.text = parts[0]
        self.movieDescriptionOutlet.text = detail
        
    }

}
