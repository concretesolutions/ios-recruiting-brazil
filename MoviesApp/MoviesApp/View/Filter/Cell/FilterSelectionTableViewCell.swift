//
//  FilterSelectionTableViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 21/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class FilterSelectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var filterTitleLabelOutlet: UILabel!
    @IBOutlet weak var filterContentLabelOutlet: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(filterTitle: String){
        
        self.filterTitleLabelOutlet.text = filterTitle
        
    }

}
