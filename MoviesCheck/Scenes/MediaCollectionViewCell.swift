//
//  MediaCollectionViewCell.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class MediaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var favStarImageView: UIImageView!
    
    func setMedia(mediaItem:MediaItem){
        
        let posterURL = mediaItem.getThumbnailUrl()
        
        if(posterURL == "noposter"){
            posterImageView.image = UIImage(named: "defaultPoster")
        }else{
            posterImageView.loadImage(fromURL: posterURL)
        }
        
        titleLabel.text = mediaItem.title
        yearLabel.text = mediaItem.getYear()
        
        if(DatabaseWorker.shared.isFavorited(media: mediaItem)){
            favStarImageView.image = UIImage(named: "favorited")
        }else{
            favStarImageView.image = UIImage(named: "unfavorited")
        }
        
        
    }
    
}
