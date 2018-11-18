//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by Adann Simões on 18/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: Favorite) {
        if let posterPath = data.posterPath {
            setPosterImage(posterPath)
        }
        if let releaseDate = data.releaseDate {
            setYearRelease(releaseDate as Date)
        }
        movieTitleLabel.text = data.title
        overviewLabel.text = data.overview
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func setPosterImage(_ posterPath: String) {
        let endpoint = URL(string: APIRoute.ImageW500.rawValue + posterPath)
        let placeholder = UIImage(named: "@popularMovies-placeholder")
        posterImage.kf.setImage(with: endpoint, placeholder: placeholder)
    }
    
    private func setYearRelease(_ date: Date) {
        let myCalendar = Calendar(identifier: .gregorian)
        let year = myCalendar.component(.year, from: date)
        releaseDateLabel.text = "Ano: \(year)"
    }

}
