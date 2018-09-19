//
//  DetailMovieViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit
import JonAlert

class DetailMovieViewController: BaseViewController {

    var movie:Movie!
    private var isFavorite = false

    private unowned var detailMovieView: DetailMovieView{ return self.view as! DetailMovieView }

    private unowned var movieGenre:UILabel      { return detailMovieView.movieGenre   }
    private unowned var movieOverview:UILabel   { return detailMovieView.movieOverview }
    private unowned var movieTitle:UILabel      { return detailMovieView.movieName     }
    private unowned var movieRelease:UILabel    { return detailMovieView.movieDate     }
    private unowned var moviePoster:UIImageView { return detailMovieView.poster        }

    override func loadView() {
        self.view = DetailMovieView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setTranslucentNavigationBar()
        setFilterButton()
        setMovieInfo()
        
        requestMovieDetail()
    }

    /// Makes the NavigationBar translucent
    private func setTranslucentNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    /// Adds the favorite button to the Controller
    private func setFilterButton(){
        isFavorite = User.current.isMovieFavorite(movie: movie)
        let favorite = UIBarButtonItem(image: UIImage(named: isFavorite ? "icon_favorite_over":"icon_favorite"), style: .plain, target: self, action: #selector(favoriteAction))
        self.navigationItem.rightBarButtonItem = favorite
    }

    /// Action to favorite the movie
    @objc private func favoriteAction(){
        User.current.favorite(movie: movie, !isFavorite)
        setFilterButton()
    }

    /// Sets the movie information
    private func setMovieInfo(){

        /// Setsthe movie poster
        if let url = movie.poster{
            moviePoster.load(url)
        }

        /// Sets the movie's name
        movieTitle.text = movie.title

        /// Sets the movies's date
        movieRelease.text = movie.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "d MMMM yyyy")

        /// Sets the overview of the movie
        movieOverview.text = movie.overview

        /// Sets the genres of the movie
        if let genres = movie.genres, genres.count > 0{
            movieGenre.text = genres.map{"\($0.name!)"}.joined(separator: ", ")
        }
    }

    /// Makes the request for the movie detail
    private func requestMovieDetail(){
        RequestMovie().detail(of: movie).responseJSON { response in
            if let data = response.data{
                if let movie = try? JSONDecoder().decode(Movie.self, from: data){
                    self.movie = movie
                    self.setMovieInfo()
                }
            }
            else{
                JonAlert.showError(message: "Not possible to load this movie")
            }
        }
    }
}
