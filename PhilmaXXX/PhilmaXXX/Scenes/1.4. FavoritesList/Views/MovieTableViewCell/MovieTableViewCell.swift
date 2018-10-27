//
//  MovieTableViewCell.swift
//  PhilmaXXX
//
//  Created by Guilherme Guimaraes on 24/10/18.
//  Copyright © 2018 Guilherme Guimaraes. All rights reserved.
//

import UIKit

struct MovieCellEntity {
	let title: String
	let year: String
	let bannerURL: URL
	
	init(title: String, year: String, bannerURL: URL) {
		self.title = title
		self.year = year
		self.bannerURL = bannerURL
	}
}

class MovieTableViewCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var posterImage: UIImageView!
	@IBOutlet weak var yearLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
	
	func setup(entityModel: MovieCellEntity){
		self.titleLabel.text = entityModel.title
		self.posterImage.kf.indicatorType = .activity
		self.posterImage.kf.setImage(with: entityModel.bannerURL)
		self.yearLabel.text = entityModel.year
	}
}
