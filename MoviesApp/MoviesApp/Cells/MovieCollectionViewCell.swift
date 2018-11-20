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
    
    override func awakeFromNib() {
        self.bottomView.backgroundColor = Palette.blue
    }
    
    static func size(forWidth width:CGFloat) ->CGSize{
        let height:CGFloat = width * 1.481481481 //Aspect Ratio for Movie Posters
        return CGSize(width: width, height: height)
    }
    
    func setup(withMovie movie:Movie){
        self.title.text = movie.title
        if let poster = movie.posterPath{
            self.imageView.download(image: poster)
        }else{
            self.imageView.image = UIImage(named: "poster_notAvailable")
        }
        let imageName = CDMovieDAO.hasFavoriteMovie(with: movie.id) ? "favorite_full_icon" : "favorite_gray_icon"
        self.favoriteImage.image = UIImage(named: imageName)
    }
    
}
