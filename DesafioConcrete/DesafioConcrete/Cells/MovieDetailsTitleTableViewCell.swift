//
//  MovieDetailFirstSectionTableViewCell.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

final class MovieDetailsTitleTableViewCell: UITableViewCell {

    
    static func fileName() -> String {
        return String(describing: self)
    }
    
    static func nib() -> UINib {
        return UINib(nibName: fileName(), bundle: nil)
    }
    
    static func identifier() -> String {
        return "movieTitleCell"
    }
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    func setup(with item: Movie) {
        self.lblTitle.text = item.title
    }
    
    @IBAction func favoriteAction(_ sender: UIButton) {
        
    }
}
