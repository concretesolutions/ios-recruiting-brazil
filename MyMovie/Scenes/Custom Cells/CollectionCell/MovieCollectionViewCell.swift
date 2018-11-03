//
//  MovieCollectionViewCell.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 20/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//


import UIKit

class MovieCollectionViewCell: UICollectionViewCell{
	
	@IBOutlet weak var posterMovie: UIImageView!
	@IBOutlet weak var titleLb: UILabel!
	
	@IBOutlet weak var favorite: UIButton!

	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	override func prepareForReuse() {
		self.posterMovie.image = UIImage(named: "Default-568h@2x")
	}
	
	
}

