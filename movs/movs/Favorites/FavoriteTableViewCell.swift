//
//  FavoriteTableViewCell.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    func setTitle(_ text: String) {
        titleLabel.text = text
    }

}
