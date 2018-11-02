//
//  MoviesTableViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell{
    
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var detailMovie: UILabel!
    
    var movie: Movie?
    
}
