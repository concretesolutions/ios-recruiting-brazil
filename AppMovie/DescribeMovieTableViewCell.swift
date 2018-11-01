//
//  DescribeMovieTableViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 27/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class DescribeMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var textInformate: UILabel!
    
    var delegate: FavoriteMovieDelegate?
    var movie = MovieNowPlaying()
    
    @IBAction func favoriterMovie(_ sender: Any) {
        self.movie.updateFavorite()
        
        if let img = self.movie.getImage(favorite: self.movie.favorite){
            if self.movie.favorite == false {
                delegate?.removeFavorite(movie: movie)
            }else {
                delegate?.setFavorite(movie: movie)
            }
            self.btnFavorite.setImage(img, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.btnFavorite.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
