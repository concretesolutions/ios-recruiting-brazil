//
//  MovieElementCollectionViewCell.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Kingfisher
import Lottie

class MovieElementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var viewFavorite: AnimationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupFavoriteView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageMovie.kf.cancelDownloadTask()
        self.imageMovie.image = nil
    }
}

extension MovieElementCollectionViewCell {
    func prepareCell(viewData: MovieElementViewData) {
        if viewData.urlImageCover.isEmpty {
            self.imageMovie.image = UIImage()
        }else {
            self.downloadImage(urlString: viewData.urlImageCover)
        }
        self.labelNameMovie.text = viewData.title
        if viewData.detail.isFavorited {
            self.showFavorite()
        }else {
            self.hideFavorite()
        }
    }
    
    private func setupFavoriteView() {
        let animation = Animation.named("favourite_app_icon")
        viewFavorite.animation = animation
    }
    
    private func downloadImage(urlString: String) {
        if let url:URL = URL(string: urlString){
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            let processor = DownsamplingImageProcessor(size: self.imageMovie.bounds.size)
                >> RoundCornerImageProcessor(cornerRadius: 0)
            self.imageMovie.kf.indicatorType = .activity
            
            self.imageMovie.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(0.8)), .cacheOriginalImage, .processor(processor)], progressBlock: nil) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        break
                    case .failure(_):
                        self.imageMovie.image = UIImage()
                        break
                    }
                }
            }
        }
    }
    
    public func showFavorite() {
        self.viewFavorite.isHidden = false
        self.viewFavorite.play()
    }
    
    public func hideFavorite() {
        self.viewFavorite.stop()
        self.viewFavorite.isHidden = true
    }
}
