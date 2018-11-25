//
//  FilterTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var outletContentView: UIView!
    @IBOutlet weak var outletDescription: UILabel!
    @IBOutlet weak var outletValueChoosen: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
        // Configure the view for the selected state
    }

    func setup(withDescription description: String, andValue value: String?){
        DesignManager.applyShadow(toView: self.outletContentView)
        self.outletDescription.text = description
        self.outletValueChoosen.text = value
    }
    
}
