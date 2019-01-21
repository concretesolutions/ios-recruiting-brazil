//
//  MoviesCollectionViewCell.swift
//  Movs
//
//  Created by Franclin Cabral on 1/18/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func favorite(_ sender: Any) {
        
    }
    
    public func configure(movie: Movie) {
        movieTitle.text = movie.title
        
        let url = URL(string: movie.posterPath)!
        let placeholderImage = UIImage(named: "launch_screen")!
        
        image.af_setImage(withURL: url, placeholderImage: placeholderImage)
        favoriteBtn.setImage(
            UIImage(named: isFavorited(movie) ? "favorite_full" : "favorite_empty"), for: UIControl.State.normal
        )
    }
    
    //TODO: This is kind duplicated with FavoriteDetailViewController... I need to think of a better way
    func isFavorited(_ currentMovie: Movie) -> Bool {
        let dataStore = ManagerCenter.shared.factory.dataStore
        let movies = dataStore.read(Movie.self, matching: nil)
        guard let movie = (movies.first { $0.id == currentMovie.id }) else {
            return false
        }
        return movie.favorited
    }
}
