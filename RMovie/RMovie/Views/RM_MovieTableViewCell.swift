//
//  RM_MovieTableViewCell.swift
//  RMovie
//
//  Created by Renato Mori on 05/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import UIKit

class RM_MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblYear: UILabel!
    @IBOutlet weak var lblDescricao: UILabel!
    @IBOutlet weak var imgFavorite: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
