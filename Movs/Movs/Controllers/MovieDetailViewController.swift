//
//  MovieDetailViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit
import Kingfisher

class MovieDetailViewController: UIViewController {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieCategory: UILabel!
    @IBOutlet weak var movieSinopse: UILabel!
    @IBOutlet weak var movieFavoButton: UIButton!
    
    var movie: MovieModel!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.movieTitle.text = self.movie.title
        self.movieYear.text = self.movie.year
        self.movieSinopse.text = self.movie.sinopse
        
        let imageFav = movie.favority ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")
        
        self.movieFavoButton.setImage(imageFav, for: .normal)
        
        let paceholder = #imageLiteral(resourceName: "placeholder")
        if let url = URL(string: movie.posterURl){
            self.moviePoster.kf.setImage(with: url, placeholder: paceholder)
        }else{ self.moviePoster.image = paceholder }
        
        let genres: [String] = LocalDataHelper.shared.getGenres().filter { [unowned self] (genre) -> Bool in
            return self.movie.genresIds.contains(genre.id)
        }.map({$0.name})
        
        self.movieCategory.text = genres.joined(separator: ", ")
    }
    
    @IBAction func movieFavoButtonPressed(_ sender: Any) {
        LocalDataHelper.shared.saveMovie(movie: movie)
    }
}
