//
//  FilteringTableViewCell.swift
//  Movs
//
//  Created by Adann Simões on 25/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class FilteringTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setData(title: String, filterChoosen: String?) {
        titleLabel.text = title
        if let detail = filterChoosen {
            detailLabel.text = detail
        } else {
            detailLabel.text = ""
        }
    }

}
