//
//  TableCellClass.swift
//  Movs
//
//  Created by Pedro Clericuzi on 21/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit

class TableCellClass:UITableViewCell {
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
    @IBOutlet weak var yearMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
