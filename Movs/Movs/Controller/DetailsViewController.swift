//
//  DetailsViewController.swift
//  Movs
//
//  Created by Ygor Nascimento on 24/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    //Outlets
    @IBOutlet weak var movieDetailImage: UIImageView!
    @IBOutlet weak var movieDetailTitlelabel: UILabel!
    @IBOutlet weak var movieDetailYearLabel: UILabel!
    @IBOutlet weak var movieDetailGenreLabel: UILabel!
    @IBOutlet weak var movieDetailTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //Core Data Variables
    var managedContext: NSManagedObjectContext!
    var stackContext = CoreDataStack(modelName: "MoviesModel").managedContext
    var favoriteMovieToSave: FavoriteMovie?
    
    
    //Variables
    var selectedMovie: Movie!
    let tmdbBaseBackdropImageURL = "https://image.tmdb.org/t/p/w780"
    let tmdbBaseGenreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=3d3a97b3f7d3075c078e242196e44533&language=en-US"
    var genresArray = [GenreData]()
    var genre1 = ""
    var genre2 = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backdropImageURL = URL(string: tmdbBaseBackdropImageURL+selectedMovie.backdrop_path)!
        let imageData = try? Data(contentsOf: backdropImageURL)
        TMDBClient.loadApi(url: tmdbBaseGenreURL, onComplete: { (genre) in
            self.genresArray = genre.genres
        }) { (error) in
            print(error)
        }
        
        movieDetailImage.image = UIImage(data: imageData!)
        movieDetailTitlelabel.text = "Title:  \(selectedMovie.title)"
        movieDetailYearLabel.text = "Release Date:  \(selectedMovie.release_date)"
        genres()
        movieDetailGenreLabel.text = "Genre:  \(genre1), \(genre2)"
        movieDetailTextView.textContainer.lineFragmentPadding = 0
        movieDetailTextView.text = "Overview:  \(selectedMovie.overview)"
        
        //Core Data
        let movieTitle = selectedMovie.title
        let movieFetch: NSFetchRequest<FavoriteMovie> = FavoriteMovie.fetchRequest()
        movieFetch.predicate = NSPredicate(format: "%K==%@", #keyPath(FavoriteMovie.title), movieTitle)
        
        do {
            let results = try stackContext.fetch(movieFetch)
            if results.count > 0 {
                favoriteButton.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
            }
        } catch let error as NSError{
            print("Fetch error:\(error) description:\(error.userInfo)")
        }
    }
    
    func genres() {
        genre1 = "\(selectedMovie.genre_ids.count)" 
        }
    
    @IBAction func addToFavorite(_ sender: UIButton) {
        
        if favoriteButton.imageView?.image == UIImage(named: "favorite_empty_icon.png") {
            saveToCoreData()
            favoriteButton.setImage(UIImage(named: "favorite_full_icon.png"), for: .normal)
        }
    }
    
    private func saveToCoreData() {
        do {
            favoriteMovieToSave = FavoriteMovie(context: stackContext)
            favoriteMovieToSave?.title = selectedMovie.title
            favoriteMovieToSave?.release_date = selectedMovie.release_date
            favoriteMovieToSave?.overview = selectedMovie.overview
            try stackContext.save()
        } catch let error as NSError {
            print("Erro ao salvar: \(error) description: \(error.userInfo)")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
