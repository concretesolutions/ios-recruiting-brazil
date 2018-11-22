//
//  ReleaseDateTableViewCell.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 21/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class ReleaseDateTableViewCell: UITableViewCell {

    @IBOutlet weak var releaseTitleLabelOutlet: UILabel!
    @IBOutlet weak var selectedButtonOutlet: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCell(title: String){
        
        self.releaseTitleLabelOutlet.text = title
        
    }
    

}
