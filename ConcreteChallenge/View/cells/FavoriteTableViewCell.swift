//
//  FavoriteTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 24/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(with favorite: Favorite) {

        if let posterPath = favorite.posterPath {
            let url = URL(string: Environment.MovieDBApi.imageBaseUrl)?
                .appendingPathComponent("w500")
                .appendingPathComponent(posterPath)

            coverImage!.sd_setImage(
                with: url,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        } else {
            coverImage!.sd_setImage(
                with: nil,
                placeholderImage: UIImage(named: "placeholder.png")
            )
        }

        titleLabel.text = favorite.title
        ratingLabel.text = String(format: "%.1f", favorite.voteAverage / 2)

        var yearGenre: [String] = []

        if let releaseDate = favorite.releaseDate {
            yearGenre.append(String(releaseDate.prefix(4)))
        }
        if let genreName = favorite.genres?.first {
            yearGenre.append(genreName)
        }

        genresLabel.text = yearGenre.joined(separator: " - ")

        decriptionLabel.text = favorite.overview

    }

}
