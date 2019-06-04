//
//  MovieElementCollectionViewCell.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Kingfisher

class MovieElementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelNameMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageMovie.kf.cancelDownloadTask()
        self.imageMovie.image = nil
    }
}

extension MovieElementCollectionViewCell {
    func prepareCell(viewData: MovieElement) {
        if viewData.urlImageCover.isEmpty {
            self.imageMovie.image = UIImage()
        }else {
            self.downloadImage(urlString: viewData.urlImageCover)
        }
        self.labelNameMovie.text = viewData.title
    }
    
    private func downloadImage(urlString: String) {
        if let url:URL = URL(string: urlString){
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            let processor = DownsamplingImageProcessor(size: self.imageMovie.bounds.size)
                >> RoundCornerImageProcessor(cornerRadius: 0)
            self.imageMovie.kf.indicatorType = .activity
            
            self.imageMovie.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(0.8)), .cacheOriginalImage, .processor(processor)], progressBlock: nil) { (result) in
                switch result {
                case .success(let imageResult):
                    self.imageMovie.image = imageResult.image
                    break
                case .failure(_):
                    self.imageMovie.image = UIImage()
                    break
                }
            }
        }
    }
}
