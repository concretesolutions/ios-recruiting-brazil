//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "MovieCollectionViewCell"
	static let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: Bundle.main)
	static let preferredSize = CGSize(width: 300, height: 455)
	
	public var favoriteMovie: ((_ id: Int) -> Void)?
	private var presentedMovieId: Int!

	@IBOutlet weak private var posterImageView: UIImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var genreLabel: UILabel!
	
	@IBAction private func favorite(_ sender: UIButton) {
		setSelected(sender)
		
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
	
	public func setPoster(_ posterImage: UIImage) {
		posterImageView.image = posterImage
	}
	
	// MARK: Auxiliary methods
	
	private func setSelected(_ button: UIButton) {
		
		UIButton.animate(withDuration: 0.2, animations: {
			button.isSelected = !button.isSelected
			
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
