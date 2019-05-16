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
    var stackContext = CoreDataStack(modelName: "MoviesModel").managedContext
    var favoriteMovieToSave: FavoriteMovie?
    
    //Variables
    var selectedMovie: Movie!
    let tmdbBaseBackdropImageURL = "https://image.tmdb.org/t/p/w780"
    let tmdbBasePosterImageURL = "https://image.tmdb.org/t/p/w342"
    let tmdbBaseGenreURL = "https://api.themoviedb.org/3/genre/movie/list?api_key=3d3a97b3f7d3075c078e242196e44533&language=en-US"
    var genresArray = [GenreData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backdropImageURL = URL(string: tmdbBaseBackdropImageURL+selectedMovie.backdrop_path)!
        let imageData = try? Data(contentsOf: backdropImageURL)
        
        genres()
        movieDetailImage.image = UIImage(data: imageData!)
        movieDetailTitlelabel.text = "Title:  \(selectedMovie.title)"
        movieDetailYearLabel.text = "Release Date:  \(selectedMovie.release_date)"
        movieDetailTextView.textContainer.lineFragmentPadding = 0
        movieDetailTextView.text = "Overview:  \(selectedMovie.overview)"
        
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
    
    private func genres() {
        var names = [String]()
        let url = URL(string: tmdbBaseGenreURL)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            guard let jsonData = data else {
                print("Error, no data")
                return
            }
            do {
                let json = try JSONDecoder().decode(Genre.self, from: jsonData)
                self.genresArray = json.genres
                for genre in self.genresArray {
                    for genreId in self.selectedMovie.genre_ids {
                        if genreId == genre.id {
                            names.append(genre.name)
                        }
                    }
                }
                DispatchQueue.main.async {
                    if names.indices.contains(1) {
                        self.movieDetailGenreLabel.text = "Genres: \(names[0]), \(names[1])"
                    } else {
                        self.movieDetailGenreLabel.text = "Genres: \(names[0])"
                    }
                }
            } catch {
                print(error)
            }
        }
        dataTask.resume()
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
            
            let imageUrl = URL(string:tmdbBasePosterImageURL+selectedMovie.poster_path)!
            let imageRequest = URLRequest(url: imageUrl)
            let imageCache = URLCache.shared
            let data = imageCache.cachedResponse(for: imageRequest)?.data
            let image = UIImage(data: data!)
            favoriteMovieToSave?.poster = image
            try stackContext.save()
            
        } catch let error as NSError {
            print("Erro ao salvar: \(error) description: \(error.userInfo)")
        }
    }
}
