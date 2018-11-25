//
//  FavoriteMovieTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 16/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class GenreFilterTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    // MARK: - Properties
    var genre: Genre? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Functions
    func setupCell(genre: Genre) {

    }
}
