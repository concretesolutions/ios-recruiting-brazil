//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Lucas Ferraço on 16/09/18.
//  Copyright © 2018 Lucas Ferraço. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellProtocol {
	func image(forMovieId id: Int, _ completion: @escaping (UIImage) -> Void)
}

class MovieCollectionViewCell: UICollectionViewCell {
	
	static let identifier = "MovieCollectionViewCell"
	static let nib = UINib(nibName: MovieCollectionViewCell.identifier, bundle: Bundle.main)
	static let preferredSize = CGSize(width: 300, height: 455)
	
	private var presentedMovieId: Int! = -1
	public var delegate: MovieCollectionViewCellProtocol?
	public var didFavoritedMovie: ((_ movieId: Int) -> Void)?

	@IBOutlet weak private var posterImageView: UIImageView!
	@IBOutlet weak private var titleLabel: UILabel!
	@IBOutlet weak private var genreLabel: UILabel!
	@IBOutlet weak var favoriteButton: UIButton!
	
	@IBAction private func favorite(_ sender: UIButton) {
		setSelected(sender)
		
		didFavoritedMovie?(presentedMovieId)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		favoriteButton.isSelected = false
		posterImageView.layer.masksToBounds = true
		posterImageView.layer.cornerRadius = 5.0
	}
	
	public func configure(with formattedMovieModel: ListMovies.FormattedMovieInfo)  {
		presentedMovieId = formattedMovieModel.id
		titleLabel.text = formattedMovieModel.title
		genreLabel.text = formattedMovieModel.mainGenre
		setSelected(favoriteButton, to: formattedMovieModel.isFavorite)
		
		delegate?.image(forMovieId: presentedMovieId, { (image) in
			self.posterImageView.image = image
		})
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
