//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Ygor Nascimento on 05/05/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit
import CoreData

class FavoritesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var favoriteCellImage: UIImageView!
    @IBOutlet weak var favoriteCellTitle: UILabel!
    @IBOutlet weak var favoriteCellReleaseDate: UILabel!
    @IBOutlet weak var favoriteCellOverview: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
