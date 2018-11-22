//
//  MovieCollectionViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 11/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class MovieCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        self.bottomView.backgroundColor = Palette.blue
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.setup(withMovie: nil)
    }
    
    static func size(forWidth width:CGFloat) ->CGSize{
        let height:CGFloat = width * 1.481481481 //Aspect Ratio for Movie Posters
        return CGSize(width: width, height: height)
    }
    
    func setup(withMovie movie:Movie?){
        if let movie = movie{
            self.title.text = movie.title
            if let poster = movie.posterPath{
                self.imageView.download(image: poster)
            }else{
                self.imageView.image = UIImage.poster.notAvailable
            }
            self.favoriteImage.image = CDMovieDAO.hasFavoriteMovie(with: movie.id) ? UIImage.favorite.fullHeart : UIImage.favorite.grayHeart
            self.activityIndicator.stopAnimating()
        }else{
            self.title.text = "Loading..."
            self.imageView.image = UIImage.poster.notAvailable
            self.favoriteImage.image = UIImage.favorite.grayHeart
            self.activityIndicator.startAnimating()
        }
    }
    
}
