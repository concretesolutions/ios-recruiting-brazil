//
//  FavoriteTableViewCell.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {
    static let nib = UINib(nibName: "FavoriteTableViewCell", bundle: nil)
    static let identifier = "FavoriteTableViewCellID"
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func prepareCell(movie: MovieData) {
        self.movieImageView.sd_setImage(with: movie.posterPath.toImageUrl(), completed: nil)
        self.titleLabel.text = movie.originalTitle
        self.releaseDateLabel.text = DateUtil.convertDateStringToString(dateString: movie.releaseData, formatter: "yyyy-MM-dd", toFormatter: "yyyy")
        self.overviewLabel.text = movie.overview
    }
}
