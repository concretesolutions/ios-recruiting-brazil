//
//  MediaTableViewCell.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {

    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var yearOfReleaseLabel: UILabel!
    
    func setMedia(mediaItem:MediaItem){
        
        let posterURL = mediaItem.getThumbnailUrl()
        
        if(posterURL == "noposter"){
            posterImageView.image = UIImage(named: "defaultPoster")
        }else{
            posterImageView.loadImage(fromURL: posterURL)
        }
        
        let ratingValue = mediaItem.evaluation * 100 / 10
        ratingLabel.text = String(format: "Rating: %.0f%%", ratingValue)
        
        titleLabel.text = mediaItem.title
        yearOfReleaseLabel.text = mediaItem.getYear()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
