//
//  MovieDetailViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {
    
    //Mark: Proprietes
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var titleMovies: UILabel!
    @IBOutlet weak var dateMovies: UILabel!
    @IBOutlet weak var genersTxt: UILabel!
    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    var genero: String!
    
    var movieCell : Result?
    
    var status: Bool!
    
    //MARK: -Init
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        // Do any additional setup after loading the view.
        
        configureComponents()
    }
    
    func configureComponents() {
        guard let movieCell = self.movieCell else {
            titleMovies.text = "Error on Movie"
            navigationItem.title = "Error"
            return
        }
        
        titleMovies.text = movieCell.title
        dateMovies.text = movieCell.release_date
        descriptionTxt.text = movieCell.overview!.isEmpty ? "No description" : movieCell.overview
        configureGenersId()
        genersTxt.text = genero
        
        detailImage.kf.indicatorType = .activity
        //let stringImage = movie?.poster_path
        guard let stringImage = movieCell.poster_path else {return}
        let Image = "\(URL_IMG)\(stringImage)"
        detailImage.download(image: Image )
        
        status = false
        
        if (movieCell.isFavorite == true){
            self.favoriteBtn.isSelected = true
        }
    }
    
    func configureGenersId(){
        guard let geners = movieCell?.genre_ids else {return}
        if geners.isEmpty {return genero = "Unknow"}
        switch(geners[0]){
        case (28):
            genero = "Action"
        case (12):
            genero = "Adventure"
        case (16):
            genero = "Animation"
        case (35):
            genero = "Comedy"
        case (80):
            genero = "Crime"
        case (99):
            genero = "Documentary"
        case (18):
            genero = "Drama"
        case (10751):
            genero = "Family"
        case (14):
            genero = "Fantasy"
        case (36):
            genero = "History"
        case (27):
            genero = "Horror"
        case (10402):
            genero = "Music"
        case (9648):
            genero = "Mystery"
        case (10749):
            genero = "Romance"
        case (878):
            genero = "Science Fiction"
        case (10752):
            genero = "War"
        case (10752):
            genero = "War"
        default:
            genero = "Unknow"
        }
    }
    
     //MARK: - COREDATA SAVE
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        guard let movie = movieCell else {return}
        let manegerCoreData = ManegerCoreData()
        let predicate = NSPredicate(format: "id = %@", argumentArray: [movieCell?.id])
        print(movieCell?.isFavorite)
        if (movieCell?.isFavorite != true){
            manegerCoreData.save(bindToMovieEntity(movie), successCompletion: {
                self.favoriteBtn.isSelected = true
                self.movieCell?.isFavorite = true
                print(self.movieCell?.isFavorite)
                print(self.movieCell?.id)
                self.EmptyTextField(text: "Adicionado", message: "Este filme foi adicionado aos favoritos!")
            }) { (error) in
                self.favoriteBtn.isSelected = false
                self.EmptyTextField(text: "Errroouuu", message: "Este filme não foi adicionado aos favoritos!")
            }
        }
        else { self.EmptyTextField(text: "Ja adicionado", message: "Este filme já está adicionado aos favoritos!") }
        
    }
    
    private func bindToMovieEntity(_ movie: Result) -> MovieEntity {
        let movie = MovieEntity(context: getCoreDataContext())
        movie.moveId = movieCell?.id ?? 0
        movie.movieDescription = movieCell?.overview
        movie.movieTitle = movieCell?.title
        movie.movieDate = movieCell?.release_date
        movie.movieImage = movieCell?.poster_path
        movie.movieIsFavorite = true
        
        return movie
    }
    
    func getCoreDataContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}
