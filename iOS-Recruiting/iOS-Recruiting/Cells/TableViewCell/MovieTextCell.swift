//
//  MovieTextCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 17/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class MovieTextCell: UITableViewCell {
    @IBOutlet weak var mainTextLabel: UILabel!
    
}


extension MovieTextCell: ReusableView, NibLoadableView {}
