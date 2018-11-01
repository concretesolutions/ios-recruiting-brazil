//
//  ImageGateway.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import Kingfisher

class ImageKingFisherGateway: ImageFetcher {
    func fetchImage(from url: URL, to imageView: UIImageView) {
        imageView.kf.setImage(with: url, placeholder: Images.poster_placeholder, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
