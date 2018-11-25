//
//  FilterDetailTableViewCell.swift
//  Movs
//
//  Created by Adann Simões on 25/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class FilterDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(genre: String? = nil, year: Int? = nil) {
        if let genre = genre {
            titleLabel.text = genre
        } else if let year = year {
            titleLabel.text = String(year)
        }
    }

}
