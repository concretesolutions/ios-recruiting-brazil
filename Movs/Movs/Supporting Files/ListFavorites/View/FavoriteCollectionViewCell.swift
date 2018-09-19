//
//  FavoriteCollectionViewCell.swift
//  Movs
//
//  Created by Lucas Ferraço on 19/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {

	static let identifier = "FavoriteCollectionViewCell"
	static let nib = UINib(nibName: FavoriteCollectionViewCell.identifier, bundle: Bundle.main)
	static let preferredSize = CGSize(width: 380, height: 680)
	
	private var presentedMovieId: Int! = -1
	public var didFavoritedMovie: ((_ movieId: Int) -> Void)?
	
	@IBOutlet weak private var posterImageView: UIImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var genreLabel: UILabel!
	@IBOutlet weak var favoriteButton: UIButton!
	@IBOutlet weak var overviewLabel: UILabel!
	
	@IBAction private func favorite(_ sender: UIButton) {
		setSelected(sender)
		
		didFavoritedMovie?(presentedMovieId)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		favoriteButton.isSelected = true
		setSelected(favoriteButton, to: true)
		posterImageView.layer.masksToBounds = true
		posterImageView.layer.cornerRadius = 5.0
	}
	
	public func configure(with formattedMovieModel: ListFavorites.FormattedMovieInfo)  {
		presentedMovieId = formattedMovieModel.id
		titleLabel.text = formattedMovieModel.title
		genreLabel.text = formattedMovieModel.genres
		posterImageView.image = formattedMovieModel.image
		overviewLabel.text = formattedMovieModel.overview
	}
	
	// MARK: Auxiliary methods
	
	private func setSelected(_ button: UIButton, to isSelected: Bool? = nil) {
		
		UIButton.animate(withDuration: 0.2, animations: {
			if let isSelected = isSelected {
				button.isSelected = isSelected
			} else {
				button.isSelected = !button.isSelected
			}
			
			if button.isSelected {
				button.tintColor = .red
			} else {
				button.tintColor = .white
			}
			
			button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
		}, completion: { finish in
			UIButton.animate(withDuration: 0.2, animations: {
				button.transform = CGAffineTransform.identity
			})
		})
	}
}
