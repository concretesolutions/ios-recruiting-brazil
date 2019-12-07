//
//  FavoriteMovieTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 06/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "favoriteMovieTableView"
    }
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    
    func setup(with item: Movie) {
        self.imgMovie.downloaded(from: item.posterPath, contentMode: .scaleAspectFill)
        self.lblTitle.text = item.title
        self.lblReleaseDate.text = String(item.releaseDate.prefix(4))
        self.lblOverview.text = item.overview
    }
}
