//
//  FavoritesTableViewCell.swift
//  movs
//
//  Created by Isaac Douglas on 26/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            self.iconView.image = movie.image
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            
            guard let date = movie.releaseDate.date else { return }
            let year = Calendar.current.component(.year, from: date)
            self.yearLabel.text = "\(year)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
