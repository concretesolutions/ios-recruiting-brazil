//
//  MovieDetailVC.swift
//  Movs
//
//  Created by Rafael Douglas on 20/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit
import CoreData
import AlamofireImage

class MovieDetailVC: UIViewController {
    
    
    @IBOutlet weak var movieDetailPoster: UIImageView!
    @IBOutlet weak var movieDetailTitle: UILabel!
    @IBOutlet weak var movieDetailYear: UILabel!
    @IBOutlet weak var movieDetailGenders: UILabel!
    @IBOutlet weak var movieDetailOverview: UILabel!
    @IBOutlet weak var movieDetailIsFavoritedBtn: UIButton!
    
    var moviesDB: Movies!
    var movieWasAdded:Bool = false
    var movie: Movie?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieId = self.movie?.id{
            getDetailFromApi(movieId: movieId)
        }
    }
    
    func getDetailFromApi(movieId: Int){
        MovieDBApi.getDetailMovie(id: movieId, onComplete: { (movieDetail) in
            self.movie = movieDetail
            self.setupScreen()
        }) { (err) in
            print(err.localizedDescription)
        }
    }
    
    func setupScreen(){
        if let poster_path = self.movie?.poster_path{
            let url = URL(string: API_MOVIEDB_URL_IMAGE_BASE+poster_path)!
            self.movieDetailPoster.af_setImage(withURL: url)
        }
        if let title = self.movie?.title {
            self.movieDetailTitle.text = title
        }
        if let released_date = self.movie?.release_date {
            let movieDetailYear = Helper.getYearfromDateString(released_date)
            self.movieDetailYear.text = movieDetailYear
        }
        if let genresArr = self.movie?.genres {
            let genresString = getGendersInString(genres: genresArr)
            self.movieDetailGenders.text = genresString
        }
        if let overview = self.movie?.overview {
            self.movieDetailOverview.text = overview
        }
        //Verify if movie were favorited
        //Get Icon depends if movie was added or not
        movieWasAdded = CoreDataDelegate.movieWasAdded(movie: self.movie!)
        if(movieWasAdded == true){
            self.movieDetailIsFavoritedBtn.setImage(UIImage(named: "favorite_icon"), for: UIControl.State.normal)
        }else{
            self.movieDetailIsFavoritedBtn.setImage(UIImage(named: "favorite_icon_empty"), for: UIControl.State.normal)
        }
    }
    
    func getGendersInString(genres:[Genre])-> String{
        var genresString = ""
        for genre in genres{
            if(genresString == ""){
                genresString = "\(genre.name!)"
            }else{
                genresString += ", \(genre.name!)"
            }
        }
        return genresString
    }
    
    @IBAction func favoriteMovie(_ sender: Any) {
        if(self.movieWasAdded == false){
            //Creating an instance from DB
            moviesDB = Movies(context: context)
            if let movieId = movie?.id {
                moviesDB.id = Int32(movieId)
            }
            if let movieTitle = movie?.title {
                moviesDB.title = movieTitle
            }
            if let movieOverview = movie?.overview {
                moviesDB.overview = movieOverview
            }
            if let movieVoteAverage = movie?.vote_average {
                moviesDB.vote_average = movieVoteAverage
            }
            if let moviePosterPath = movie?.poster_path {
                moviesDB.poster_path = moviePosterPath
            }
            if let movieReleaseDate = movie?.release_date {
                moviesDB.release_date = movieReleaseDate
            }
            
            do {
               try context.save()
               self.movieDetailIsFavoritedBtn.setImage(UIImage(named: "favorite_icon"), for: UIControl.State.normal)
            } catch {
               print(error.localizedDescription)
            }
        }else{
            print("movie has already been added!")
        }
    }
}
