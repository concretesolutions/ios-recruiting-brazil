//
//  OverviewTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 23/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class OverviewTableViewCell: UITableViewCell, FilmCell {
    
    @IBOutlet weak var outletOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(withFilm film: ResponseFilm){
        self.outletOverviewLabel.text = film.overview
    }
}
