//
//  CheckTableViewCell.swift
//  Mov
//
//  Created by Allan on 16/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class CheckTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak private var lblTitle: UILabel!
    @IBOutlet weak private var imgViewCheck: UIImageView!
    
    //MARK: - Functions
    
    func setup(with title: String, showCheckMark: Bool){
        lblTitle.text = title
        imgViewCheck.isHidden = !showCheckMark
    }

}
