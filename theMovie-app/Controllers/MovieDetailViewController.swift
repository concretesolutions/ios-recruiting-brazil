//
//  MovieDetailViewController.swift
//  theMovie-app
//
//  Created by Adriel Alves on 30/12/19.
//  Copyright © 2019 adriel. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var ivMoviePoster: UIImageView!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbMovieYear: UILabel!
    @IBOutlet weak var lbMovieGenres: UILabel!
    @IBOutlet weak var tvMovieOverview: UITextView!
    @IBOutlet weak var btFavorite: UIButton!
    
    var movieDetail: MovieViewModel!
    
    private var genres: [Genre] = []
    
    private var genresService = GenresServiceImpl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movieDetail.delegate = self
        movieDetail.movieGenresList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isFavorite()
    }
    
    func isFavorite() {
        btFavorite.setImage(movieDetail.favoriteButtonImage, for: .normal)
    }
    
    func genreList() -> String {
        return movieDetail.genresList.map({$0.name}).joined(separator: ", ")
    }
    
    @IBAction func addOrRemoveFavoriteMovie(_ sender: Any) {
        
//        favoriteMovie.moviePoster = ivMoviePoster.image
        movieDetail.addOrRemoveFavoriteMovie(favoriteMovie: movieDetail)
        isFavorite()
        
    }
}

extension MovieDetailViewController: MovieViewModelDelegate {
    
    func didFinishSuccessRequest() {
        lbMovieGenres.text = genreList()
        //ivMoviePoster.load(url: movieDetail.posterPath!)
        ivMoviePoster.kf.indicatorType = .activity
        ivMoviePoster.kf.setImage(with: movieDetail.posterPath)
        lbMovieTitle.text = movieDetail.title
        lbMovieYear.text = movieDetail.year
        tvMovieOverview.text = movieDetail.overview
        btFavorite.setImage(movieDetail.favoriteButtonImage, for: .normal)
    }
    
    func didFinishFailureRequest(error: APIError) {
        print(APIError.taskError(error: error))
    }
}
