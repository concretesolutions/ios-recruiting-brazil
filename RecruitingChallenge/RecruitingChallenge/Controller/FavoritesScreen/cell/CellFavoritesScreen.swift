//
//  cellFavoritesScreen.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 12/9/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit

class CellFavoritesScreen: UITableViewCell {

    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var uiTitleLbl: UILabel!
    @IBOutlet weak var uiYearLbl: UILabel!
    @IBOutlet weak var uiDescLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
