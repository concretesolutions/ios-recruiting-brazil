//
//  DetailTableViewCell.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 08/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        
    }
    
    func setup(with section: Section) {
        
        switch section {
        case .image(let data):
            self.imageView?.image = UIImage(data: data)
            
        case .text(let text):
            self.textLabel?.text = text
            
        case .textWithButton(let text):
            self.textLabel?.text = text
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
