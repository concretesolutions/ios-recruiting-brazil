//
//  MovieElementCollectionViewCell.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class MovieElementCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    
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
        if viewData.urlImage.isEmpty {
            self.imageMovie.image = UIImage()
        }else {
            self.downloadImage(urlString: viewData.urlImage)
        }
        self.labelNameMovie.text = viewData.title
        self.labelDate.text = viewData.releaseDate
        self.viewRating.rating = viewData.rating
    }
    
    private func downloadImage(urlString: String) {
        if let url:URL = URL(string: urlString){
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            let processor = DownsamplingImageProcessor(size: self.imageMovie.bounds.size)
                >> RoundCornerImageProcessor(cornerRadius: 20)
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
