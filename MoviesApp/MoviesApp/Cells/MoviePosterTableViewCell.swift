//
//  MoviePosterTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class MoviePosterTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie:Movie){
        if let poster = movie.posterPath{
            self.posterImageView?.download(image: poster)
        }else{
            self.posterImageView.image = UIImage(named: "poster_notAvailable")
        }
    }

}
