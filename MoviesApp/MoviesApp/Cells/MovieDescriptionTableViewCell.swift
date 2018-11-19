//
//  MovieDescriptionTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class MovieDescriptionTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with movie:Movie){
        self.label.text = movie.overview
    }
    
}
