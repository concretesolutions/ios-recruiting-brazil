//
//  FavoriteTableViewCell.swift
//  Mov
//
//  Created by Allan on 09/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak private var imgViewMovie: UIImageView!
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var lblDescription: UILabel!
    @IBOutlet weak private var lblYear: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie: Movie){
        if let urlString = movie.imageURL, let url = URL(string: urlString){
            imgViewMovie.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), options: [], completed: nil)
        }
        lblTitle.text = movie.title
        lblDescription.text = movie.overview
        lblYear.text = movie.releaseDate.year
    }

}
