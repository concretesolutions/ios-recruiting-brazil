//
//  FilterChooseTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 25/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FilterChooseTableViewCell: UITableViewCell {

    @IBOutlet weak var outletContentView: UIView!
    @IBOutlet weak var outletInfoLable: UILabel!
    @IBOutlet weak var outletCheckImageView: UIImageView!
    var isChecked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func setImage(){
        if self.isChecked{
            self.outletCheckImageView.image = UIImage(named: "Check")
        }else{
            self.outletCheckImageView.image = nil
        }
    }
    
    func setup(name: String?, andCheckState state: Bool){
        DesignManager.applyShadow(toView: self.outletContentView)
        self.outletInfoLable.text = name
        self.isChecked = state
        self.setImage()
    }

}
