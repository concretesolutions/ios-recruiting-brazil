//
//  FavoriteMovieTableViewCell.swift
//  Movs
//
//  Created by Tiago Chaves on 16/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var yearLabel: UILabel!
	@IBOutlet weak var overviewLabel: UILabel!
	
	let imageUrl = "https://image.tmdb.org/t/p/w500"
	
	override func prepareForReuse() {
		
		posterImageView.image = nil
		titleLabel.text = ""
		yearLabel.text = ""
		overviewLabel.text = ""
	}

	func config(withMovie movie:FavoriteMovieViewModel) {
		
		if let posterUrl = movie.posterUrl {
			
			let completePosterUrl = "\(imageUrl)\(posterUrl)"
			posterImageView.setImage(withUrl: completePosterUrl)
		}
		
		titleLabel.text = movie.title ?? ""
		yearLabel.text = movie.year ?? ""
		overviewLabel.text = movie.overview ?? ""
	}
}
