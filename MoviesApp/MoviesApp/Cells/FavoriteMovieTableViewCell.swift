//
//  FavoriteMovieTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class FavoriteMovieTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie:CDMovie){
        self.background.backgroundColor = Palette.blue
        self.title.text = movie.title
        self.year.text = "\(movie.releaseDate?.getYear() ?? 0001)"
        self.descriptionLabel.text = movie.posterPath
        if let poster = movie.posterPath{
            self.posterImageView.download(image: poster)
        }else{
            self.posterImageView.image = UIImage(named: "poster_notAvailable")
        }
        
    }
    
}
