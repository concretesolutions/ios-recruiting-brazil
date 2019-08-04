//
//  FavoriteTableViewCell.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 01/08/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var favoriteMovieYear: UILabel!
    @IBOutlet weak var favoriteMovieDetails: UILabel!
    @IBOutlet weak var favoriteMovieImage: UIImageView!
    @IBOutlet weak var frameView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
