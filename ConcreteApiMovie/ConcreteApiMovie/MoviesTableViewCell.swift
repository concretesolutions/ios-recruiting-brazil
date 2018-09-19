//
//  MoviesTableViewCell.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit
import Kingfisher

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovie: UILabel!
    
    
    func prepareCell(withMovie movie:MoviesResults) {
        lblMovie.text = movie.title
        if let url = URL(string: movie.poster_path) {
            imgMovie.kf.indicatorType = .activity
            imgMovie.kf.setImage(with: url)
        } else {
            imgMovie.image = nil
        }
        
        imgMovie.layer.cornerRadius = imgMovie.frame.size.height/2
        imgMovie.layer.borderWidth = 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
