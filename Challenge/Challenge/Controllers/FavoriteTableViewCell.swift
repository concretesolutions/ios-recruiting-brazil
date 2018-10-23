//
//  FavoriteTableViewCell.swift
//  Challenge
//
//  Created by Sávio Berdine on 23/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteContentView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteTitle: UILabel!
    @IBOutlet weak var favoriteYear: UILabel!
    @IBOutlet weak var favoriteOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
