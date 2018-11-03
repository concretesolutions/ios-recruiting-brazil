//
//  FilterDateTableViewCell.swift
//  MyMovie
//
//  Created by Paulo Gutemberg on 31/10/2018.
//  Copyright © 2018 Paulo Gutemberg. All rights reserved.
//

import UIKit

class FilterDateTableViewCell: UITableViewCell {

	@IBOutlet weak var filter: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
