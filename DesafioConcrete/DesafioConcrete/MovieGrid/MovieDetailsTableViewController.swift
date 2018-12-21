//
//  MoveDetailsTableViewController.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 17/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    
    var movie: Movie?

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var isFavorite = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleLabel.text = movie?.title
        self.descriptionLabel.text = movie?.description
        self.yearLabel.text = movie?.releaseDate
        
        if let movieGenres = movie?.genres_ids, let genreList = TMDBConfiguration.shared.genres {
            var genreText = ""
            for (offset, genre) in movieGenres.enumerated() {
                if offset > 0 {
                    genreText.append(", ")
                }
                
                if let genreName = genreList[genre] {
                    genreText.append(genreName)
                }
            }
            self.genresLabel.text = genreText
        } else {
            self.genresLabel.text = "Could not load genres."
        }
        
        if let movieId = movie?.id, UserFavorites.shared.favorites.contains(movieId) {
            isFavorite = true
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            isFavorite = false
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        
        if let posterPath = movie?.posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
            let data = try? Data(contentsOf: imageURL!)
            self.posterImageView.image = UIImage(data: data!)
        } else {
            self.posterImageView.image = nil
        }
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func favorite(_ sender: Any) {
        if let movieId = movie?.id {
            if isFavorite {
                UserFavorites.shared.remove(id: movieId)
            } else {
                UserFavorites.shared.add(id: movieId)
            }
        } else {
            print("Can't favorite movie with no id.")
        }
        
        isFavorite = !isFavorite
        
        
        if isFavorite {
            favoriteButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
}
