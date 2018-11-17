//
//  PopularTableViewCell.swift
//  Movs
//
//  Created by Adann Simões on 17/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class PopularTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var voteAverageLabel: UILabel!
    @IBOutlet weak var favoriteIndicatorImage: UIImageView!
    @IBOutlet weak var popularRankingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(data: Results, popularRanking: Int, isFavorite: Bool) {
        movieTitleLabel.text = data.title
        voteAverageLabel.text = "\(data.voteAverage ?? 0.0) de 10"
        if isFavorite {
            favoriteIndicatorImage.image = UIImage(named: "@icons-favoriteSelected")
        } else {
            favoriteIndicatorImage.image = UIImage(named: "@icons-favoriteUnselected")
        }
        popularRankingLabel.text = String(popularRanking)
        print(data.backdropPath)
        print(data.posterPath)
    }

}
