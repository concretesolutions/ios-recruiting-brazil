//
//  FilterSwitchCell.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 17/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FilterSwitchCell: UITableViewCell {
    
    var checked = false {
        didSet {
            self.checkChanged()
        }
    }
    @IBOutlet weak var outletFilterTitle: UILabel!
    @IBOutlet weak var outletCheckImage: UIImageView!

    func awakeFromNib(filterTitle: String, checked: Bool) {
        super.awakeFromNib()
        // Initialization code
        self.outletFilterTitle.text = filterTitle
        self.checked = checked
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Check
    
    func changeCheck() {
        self.checked = !self.checked
        self.isSelected = false
    }
    
    private func checkChanged() {
        if self.checked {
            self.outletCheckImage.image = UIImage.init(named: "Check_Checked")
        }else{
            self.outletCheckImage.image = UIImage.init(named: "Check_Gray")
        }
    }

}
