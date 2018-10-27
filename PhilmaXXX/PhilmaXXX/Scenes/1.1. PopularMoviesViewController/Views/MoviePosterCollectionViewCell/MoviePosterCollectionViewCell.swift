//
//  MoviePosterCollectionViewCell.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 22/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit
import Domain
import Kingfisher

struct MoviePosterCellEntity {
	let title: String
	let posterURL: URL
	let stateFavorite: Bool
}

class MoviePosterCollectionViewCell: UICollectionViewCell {
	@IBOutlet weak var nameLabel: UILabel!
	
	@IBOutlet weak var poster: UIImageView!
	
	@IBOutlet weak var favoriteFlag: UIButton!
	
	func cellSize(width: CGFloat) -> CGSize {
		let height = (width * 1.5)
		return CGSize(width: width, height: height)
	}
	
	var favoriteButtonAction: ((Bool) -> ())?
	
	var favorite: Bool = false

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		contentView.backgroundColor = .black
    }
	
	func setup(entityModel: MoviePosterCellEntity){
		self.nameLabel.text = entityModel.title
		self.poster.kf.indicatorType = .activity
		self.poster.kf.setImage(with: entityModel.posterURL)
		self.favorite = entityModel.stateFavorite
		
		validateFavorite()
	}
	
	func validateFavorite(){
		if self.favorite == true {
			favoriteFlag.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
		} else {
			favoriteFlag.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
		}
	}
	
	func toggleFavorite(){
		favorite.toggle()
		validateFavorite()
	}
	
	@IBAction func toggleAction(_ sender: Any) {
		toggleFavorite()
		favoriteButtonAction?(favorite)
	}
	
}
