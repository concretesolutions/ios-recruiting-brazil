//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit
import JonAlert

class DetailMovieViewController: UIViewController {
    
    var movie:Movie?

    private unowned var detailMovieView: DetailMovieView{ return self.view as! DetailMovieView }
    
    private unowned var movieTitle:UILabel      { return detailMovieView.movieName }
    private unowned var movieRelease:UILabel    { return detailMovieView.movieDate }
    private unowned var moviePoster:UIImageView { return detailMovieView.poster    }
    
    override func loadView() {
        self.view = DetailMovieView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMovieInfo()
        requestMovieDetail()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    /// Sets the movie information
    private func setMovieInfo(){
        
        /// Setsthe movie poster
        if let url = movie?.poster{
            moviePoster.load(url)
        }
        
        /// Sets the movie's name
        movieTitle.text = movie?.title
        
        /// Sets the movies's date
        movieRelease.text = movie?.releaseDate
    }
    
    /// Makes the request for the movie detail
    private func requestMovieDetail(){
        
        guard let movie = movie else {
            JonAlert.showError(message: "Not possible to load this movie")
            return
        }
        
        RequestMovie().detail(of: movie).responseJSON { response in
            if let data = response.data, let movieinfo = try? JSONDecoder().decode(Movie.self, from: data){
                self.movie = movieinfo
            }
        }
    }
}
