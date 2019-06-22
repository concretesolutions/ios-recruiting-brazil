//
//  FavsTableViewCell.swift
//  Movs
//
//  Created by Filipe Merli on 19/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class FavsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        posterImageView.image = #imageLiteral(resourceName: "placeholder")
        //activityIndicator.hidesWhenStopped = true
    }
    
    func setCell(with movie: FavMovie?) {
        if let movie = movie {
            titleLabel?.text = movie.title
            overviewTextView.text = movie.overview
            yearLabel.text = movie.year
            //activityIndicator.startAnimating()
        }
    }
    
    
}
