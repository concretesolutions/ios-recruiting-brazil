//
//  FavoMovieTableViewCell.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit

class FavoMovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var moviePoster: UIView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieSinopse: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
