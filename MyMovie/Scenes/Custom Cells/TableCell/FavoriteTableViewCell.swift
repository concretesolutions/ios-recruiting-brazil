//
//  FavoriteTableViewCell.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 21/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell{
	
	@IBOutlet weak var cellView: UIView!
	@IBOutlet var moviePoster: UIImageView!
	@IBOutlet weak var titleLb: UILabel!
	@IBOutlet weak var descriptionLb: UILabel!
	@IBOutlet weak var releaseLb: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func layoutSubviews() {
		self.layoutIfNeeded()
	
	}
	
	override func prepareForReuse() {
		self.moviePoster.image = UIImage(named: "Default-568h@2x")
	}
	
}
