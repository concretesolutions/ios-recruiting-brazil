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
	
	@IBAction private func favorite(_ sender: UIButton) {
		setSelected(sender)
		
		didFavoritedMovie?(presentedMovieId)
	}
	
	public func configure(with formattedMovieModel: ListMovies.FormattedMovieInfo)  {
		presentedMovieId = formattedMovieModel.id
		titleLabel.text = formattedMovieModel.title
		genreLabel.text = formattedMovieModel.mainGenre
		
		delegate?.image(forMovieId: presentedMovieId, { (image) in
			self.posterImageView.image = image
			self.posterImageView.layer.cornerRadius = 15.0
			self.layoutIfNeeded()
		})
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
