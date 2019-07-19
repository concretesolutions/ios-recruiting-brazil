//
//  MovieDetailViewController.swift
//  Movie
//
//  Created by Gustavo Pereira Teixeira Quenca on 19/07/19.
//  Copyright © 2019 Gustavo Pereira Teixeira Quenca. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var voteAverage: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var downloadTask: URLSessionDownloadTask?
    
    private let dataSource = DataSource()
    
    var favMovies: [NSManagedObject] = []
    
    var selectedMovie: Movie? {
        didSet {
            if isViewLoaded {
                updateUI()
            }
        }
    }
    
    var selectedFavMovie: NSObject?
    
    
    // MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if selectedMovie != nil {
            updateUI()
        }
        
        if selectedFavMovie != nil {
            updateUIFav()
        }
        
        favorite()
    }
    
    // MARK: -Private Methods
    
    // Check if the movie is Favorite
    func favorite() {
        for data in favMovies {
            if data.value(forKey: "title") as? String == titleLabel.text {
                favButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            }
        }
    }
    
    // Delete the Favorite Movie
    func deleteMovie(movie: NSManagedObject) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovies")
        
        do {
            let test = try managedContext.fetch(fetchRequest)
            for data in test {
                if data as! NSManagedObject == movie {
                    managedContext.delete(movie)
                }
            }
            
            do {
                try managedContext.save()
                retrieveCoreData()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    // Retrieve Data from CoreData
    func retrieveCoreData() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FavoriteMovies")
        
        do {
            favMovies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: -Action (Favorite/UnFavourite Movie into CoreData)
    
    @IBAction func favMovie(_ sender: Any) {
        //MARK: -UnFavourite
        for data in favMovies {
            if data.value(forKey: "title") as? String == titleLabel.text {
                // delete fav
                deleteMovie(movie: data)
                favButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
                retrieveCoreData()
                return
            }
        }
        
        //MARK: -Favorite
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "FavoriteMovies",
                                       in: managedContext)!
        
        let fav = NSManagedObject(entity: entity,
                                  insertInto: managedContext)
        
        if case .genreResults(let list) = self.dataSource.genreState {
            for i in 0..<list.count {
                if (self.selectedMovie!.genre_ids?.contains(list[i].id!))! {
                    fav.setValue(list[i].name, forKeyPath: "genre")
                }
            }
        }
        
        if let image = posterImage.image!.pngData() as NSData? {
            fav.setValue(image, forKeyPath: "posterPath")
        } else {
            let noImage = (UIImage(named: "noImage"))!.pngData()
            fav.setValue(noImage, forKeyPath: "posterPath")
        }
        
        fav.setValue(selectedMovie?.title!, forKeyPath: "title")
        fav.setValue(selectedMovie?.release_date!, forKeyPath: "year")
        fav.setValue(selectedMovie?.overview!, forKeyPath: "overview")
        fav.setValue(selectedMovie?.vote_average, forKeyPath: "voteAverage")
        
        do {
            try managedContext.save()
            favMovies.append(fav)
            favorite()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    // MARK: -Update the Interface for Movies
    func updateUI() {
        retrieveCoreData()
        
        if let title = selectedMovie?.title {
            titleLabel.text = title
        } else {
            titleLabel.text = "No Results"
        }
        
        if let year = selectedMovie?.release_date {
            // Get only the year
            let index = year.index(year.startIndex, offsetBy: 4)
            yearLabel.text = String(year.prefix(upTo: index))
        } else {
            yearLabel.text = "No Results"
        }
        
        if let vote = selectedMovie?.vote_average {
            voteAverage.text = String(format:"%.1f", vote)
        } else {
            voteAverage.text = "0"
        }
        
        dataSource.getGenreRequest(completion: { success in
            if !success {
                print("error")
            }
            if case .genreResults(let list) = self.dataSource.genreState {
                for i in 0..<list.count {
                    if (self.selectedMovie!.genre_ids?.contains(list[i].id!))! {
                        self.genreLabel.text = list[i].name
                    }
                }
            }
        })
        
        if let overView = selectedMovie?.overview {
            overviewLabel.text = overView
        } else {
            overviewLabel.text = "No Results"
        }
        
        if let posterPath = selectedMovie?.poster_path {
            let urlImage = "https://image.tmdb.org/t/p/w200\(posterPath)"
            print(urlImage)
            posterImage.image = UIImage(named: urlImage)
            if let smallURL = URL(string: urlImage) {
                downloadTask = posterImage.loadImage(url: smallURL)
                print("Poster is \(smallURL)")
            }
        } else {
            let noImage = UIImage(named: "noImage")
            posterImage.image = noImage
        }
        favorite()
    }
    
    // MARK: -Update the Interface for Favorite Movies
    func updateUIFav() {
        
        retrieveCoreData()
        
        if let title = selectedFavMovie?.value(forKeyPath: "title") as? String  {
            titleLabel.text = title
        } else {
            titleLabel.text = "No Results"
        }
        
        if let year = selectedFavMovie?.value(forKeyPath: "year") as? String {
            // Get only the year
            let index = year.index(year.startIndex, offsetBy: 4)
            yearLabel.text = String(year.prefix(upTo: index))
        } else {
            yearLabel.text = "No Results"
        }
        
        if let overview = selectedFavMovie?.value(forKeyPath: "overview") as? String {
            overviewLabel.text = overview
        } else {
            overviewLabel.text = "No Results"
        }
        
        if let genre = selectedFavMovie?.value(forKeyPath: "genre") as? String {
            genreLabel.text = genre
        } else {
            genreLabel.text = "No Results"
        }
        
        if (selectedFavMovie?.value(forKey: "voteAverage") as? CVarArg) != nil {
            voteAverage.text =  String(format: "%@", selectedFavMovie?.value(forKey: "voteAverage") as! CVarArg)
        }
        
        if let data = selectedFavMovie?.value(forKeyPath: "posterPath") as? NSData {
            posterImage.image = UIImage(data: data as Data)
        }
        
        favButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
    }
}
