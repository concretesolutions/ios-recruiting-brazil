//
//  MovieGridCell.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class MovieGridCell: UICollectionViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var heartIconImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!


}

extension MovieGridCell: ReusableView, NibLoadableView {}
