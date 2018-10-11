//
//  PersonCollectionViewCell.swift
//  DataMovie
//
//  Created by Andre Souza on 31/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit


class PersonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var person: CastEntity? {
        didSet {
            nameLabel.text = person?.name
        }
    }

}
