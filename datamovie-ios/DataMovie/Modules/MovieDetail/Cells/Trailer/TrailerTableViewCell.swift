//
//  TrailerTableViewCell.swift
//  DataMovie
//
//  Created by Andre Souza on 05/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import AlamofireImage

class TrailerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: DMLabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    var video: VideoEntity? {
        didSet {
            
            if let videoKey = video?.key,
                let url = URL(string: TMDBUrl.videoThumb(videoKey).url) {
                thumbnailImageView.af_setImage(withURL: url, placeholderImage: #imageLiteral(resourceName: "ic_place_holder"))
            } else {
                thumbnailImageView.image = #imageLiteral(resourceName: "ic_place_holder")
            }
            
            titleLabel.text = video?.site
            nameLabel.text = video?.name
        }
    }
    
}
