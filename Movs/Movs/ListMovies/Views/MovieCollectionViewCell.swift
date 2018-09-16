//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
	
	public var favoriteMovie: ((_ id: Int) -> Void)?
	private var presentedMovieId: Int!

	@IBOutlet weak private var posterImageView: UIImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var genreLabel: UILabel!
	
	@IBAction private func favorite(_ sender: UIButton) {
		if sender.isSelected {
			sender.tintColor = .red
		} else {
			sender.tintColor = .white
		}
		
		favoriteMovie?(presentedMovieId)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		posterImageView.layer.cornerRadius = 5.0
	}
	
	public func configure(with formattedMovieModel: ListMovies.FormattedMovieInfo)  {
		presentedMovieId = formattedMovieModel.id
		posterImageView.image = formattedMovieModel.image
		titleLabel.text = formattedMovieModel.title
		genreLabel.text = formattedMovieModel.mainGenre
	}
	
}
