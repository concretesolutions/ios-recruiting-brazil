//
//  FavoriteTableViewCell.swift
//  Mov
//
//  Created by Allan on 09/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var imgViewMovie: UIImageView!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblDescription: UILabel!
    @IBOutlet weak private var lblYear: UILabel!
    
    //MARK: - Functions
    func setup(with movie: Movie){
        if let urlString = movie.imageURL, let url = URL(string: urlString){
            imgViewMovie.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
        }
        lblTitle.text = movie.title
        lblDescription.text = movie.overview
        lblYear.text = movie.releaseDate.year
    }

}
