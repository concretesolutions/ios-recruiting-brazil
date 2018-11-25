//
//  MovieInfoController.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 14/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit


class MovieInfoController: UIViewController {

    @IBOutlet weak var oMovieBanner: UIImageView!
    @IBOutlet weak var oMovieGenre: UILabel!
    @IBOutlet weak var oMovieYear: UILabel!
    @IBOutlet weak var oMovieTitle: UILabel!
    @IBOutlet weak var oMovieDescription: UILabel!
    @IBOutlet weak var oFavoriteButton: UIButton!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        let favoriteMovies = CoreDataManager.retriveData()
        
        guard let movie = movie else {return}
        
        for favoriteMovie in favoriteMovies {
            if movie.id == favoriteMovie.id{
                 oFavoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
            }
        }
        
    }
    
    
    func setup(){
        if let backdropPath = movie?.backdrop_path {
            APIRequest.getMovieBanner(inPath: movie!.backdrop_path!) { (response) in
                
                switch response {
                case .success(let image):
                    DispatchQueue.main.async {
                        self.oMovieBanner.image = image
                    }
                case .error(let error):
                    print(error)
                }
            }
        }else{
            self.oMovieBanner.image = UIImage(named: "Splash")
        }
        
        
        APIRequest.getGenreMovie(genres: self.movie!.genre_ids) { (response) in
            switch response {
            case .success(let genre):
                DispatchQueue.main.async {
                    self.oMovieGenre.text = genre
                }
            case .error(let error):
                print(error)
            }
        }
        
        oMovieYear.text = movie?.release_date.prefix(4).description
        oMovieTitle.text = movie?.original_title
        oMovieDescription.text = movie?.overview
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        oFavoriteButton.setImage(UIImage(named: "favorite_full_icon")!, for: .normal)
        guard let movie = movie else {return}
        CoreDataManager.createData(movie: movie)
    }
}
