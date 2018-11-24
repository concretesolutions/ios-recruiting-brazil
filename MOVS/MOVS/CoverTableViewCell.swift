//
//  CoverTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class CoverTableViewCell: UITableViewCell, FilmCell {

    @IBOutlet weak var outletCoverImageView: UIImageView!
    @IBOutlet weak var outletActivity: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(withFilm film: ResponseFilm){
        self.outletCoverImageView.getPoster(forFilm: film, andActivity: self.outletActivity)
    }

}
