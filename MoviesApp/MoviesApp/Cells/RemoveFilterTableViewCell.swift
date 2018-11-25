//
//  RemoveFilterTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 24/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class RemoveFilterTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = Palette.blue
        label.textColor = Palette.yellow
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
