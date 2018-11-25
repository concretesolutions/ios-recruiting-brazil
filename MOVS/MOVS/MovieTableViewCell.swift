//
//  MovieTableViewCell.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var outletCardView: UIView!
    @IBOutlet weak var outletPosterImageView: UIImageView!
    @IBOutlet weak var outletTitleLabel: UILabel!
    @IBOutlet weak var outletOverviewLabel: UILabel!
    @IBOutlet weak var outletYearLabel: UILabel!
    var film: Film!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(withFilm film: Film){
        self.film = film
        DesignManager.applyShadow(toView: self.outletCardView)
        self.outletPosterImageView.getPoster(forFilm: film)
        self.outletTitleLabel.text = film.title
        self.outletOverviewLabel.text = film.overview
        if let releaseYear = film.release_date?.split(separator: "-").first {
            self.outletYearLabel.text = String(releaseYear)
        }else{
            self.outletYearLabel.text = film.release_date
        }
    }
    
}
