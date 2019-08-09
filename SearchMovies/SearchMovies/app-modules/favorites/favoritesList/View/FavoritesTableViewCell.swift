//
//  FavoritesTableViewCell.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
import UIKit
class FavoritesTableViewCell: UITableViewCell {
    //MARK:Outlets
    @IBOutlet weak var imageIcon: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    //MARK: Functions
    func fill(name:String, descripton:String, year:String, imageIcon:UIImage) {
        DispatchQueue.main.async {
            self.nameLabel.text = name
            self.descriptionLabel.text = descripton
            self.yearLabel.text = year
            self.imageIcon.image = imageIcon
        }
    }
}
