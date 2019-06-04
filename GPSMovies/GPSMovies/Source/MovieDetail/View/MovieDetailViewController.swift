//
//  MovieDetailViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Cosmos
import Lottie
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var imageSmall: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var textFieldDescription: UITextView!
    @IBOutlet weak var viewFavorite: AnimationView!
    
    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieDetailPresenter!
    public lazy var viewData = MovieElement()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter(viewDelegate: self)
        self.addGesture()
        self.prepareView()
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieDetailViewController: MovieDetailViewDelegate {

}

//MARK: - AUX METHODS -
extension MovieDetailViewController {
    
    private func prepareView() {
        self.downloadImage(urlString: self.viewData.detail.urlImagePost, imageView: self.imagePoster)
        self.downloadImage(urlString: self.viewData.urlImageCover, imageView: self.imageSmall)
        self.labelRating.text = "\(self.viewData.detail.rating)"
        self.labelNameMovie.text = self.viewData.title
        self.labelDate.text = self.viewData.detail.releaseDate
        self.viewRating.rating = self.viewData.detail.rating
        self.textFieldDescription.text = self.viewData.detail.description
        if self.viewData.detail.isFavorited {
            self.viewFavorite.play()
        }else {
            self.viewFavorite.stop()
        }
    }
    
    private func addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.addAndRemoveFavorite))
        self.viewFavorite.addGestureRecognizer(tap)
    }
    
    @objc private func addAndRemoveFavorite() {
        let animation = Animation.named("favourite_app_icon")
        viewFavorite.animation = animation
        self.viewFavorite.play()
    }
    
    private func downloadImage(urlString: String, imageView: UIImageView) {
        if urlString.isEmpty { imageView.image = UIImage(); return}
        if let url:URL = URL(string: urlString){
            let resource = ImageResource(downloadURL: url, cacheKey: urlString)
            let processor = DownsamplingImageProcessor(size: imageView.bounds.size)
                >> RoundCornerImageProcessor(cornerRadius: 0)
            imageView.kf.indicatorType = .activity
            
            imageView.kf.setImage(with: resource, placeholder: nil, options: [.transition(.fade(0.8)), .cacheOriginalImage, .processor(processor)], progressBlock: nil) { (result) in
                switch result {
                case .success(let imageResult):
                    imageView.image = imageResult.image
                    break
                case .failure(_):
                    imageView.image = UIImage()
                    break
                }
            }
        }
    }
    
    
}
