//
//  SelectActionTableViewCell.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class SelectActionTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var lblTitle: UILabel!
    
    //MARK: - Functions
    func setup(with title: String){
        lblTitle.text = title
    }

}
