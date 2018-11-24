//
//  FilterTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class FilterTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            self.accessoryType = .checkmark
        }else{
            self.accessoryType = .none
        }
        
    }
    
    func setup(for item:String){
        self.title.text = item
    }
    
}
