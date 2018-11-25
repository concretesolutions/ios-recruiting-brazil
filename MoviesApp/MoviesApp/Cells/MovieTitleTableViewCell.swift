//
//  MovieInfoTableViewCell.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 18/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit
import Reusable

class MovieTitleTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var movie:Movie?
    var genres:[Genre] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let inset:CGFloat = 27
        self.favoriteButton.contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setFavoriteButton(hasFavorited:Bool){
        if hasFavorited{
            self.favoriteButton.setImage(UIImage.favorite.fullHeart, for: .normal)
        }else{
            self.favoriteButton.setImage(UIImage.favorite.grayHeart, for: .normal)
        }
    }
    
    func setup(with movie:Movie){
        self.label.font = self.label.font.withSize(20.0)
        self.label.text = movie.title
        self.movie = movie
        self.setFavoriteButton(hasFavorited: CDMovieDAO.hasFavoriteMovie(with: movie.id))
    }
    
    @IBAction func tapFavoriteButton(_ sender: Any) {
        if let movie = self.movie{
            CDMovieDAO.create(from: movie, genres: genres){ movie, error in
                if error != nil{
                    print("Error! Persisted Object Already Exists")                    
                }else{
                    self.setFavoriteButton(hasFavorited: true)
                }
            }
            
        }
    }
    
    
}
