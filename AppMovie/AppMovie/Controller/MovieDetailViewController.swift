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
    
    var titulo: String!
    var descricao: String!
    var imagem: String!
    var dataMovie: String!
    var genero: String!
    
    var movie: Result? {
        didSet {}
    }
    
    var movieCell : Result?
    
    
    var status: Bool!
    // geners: String
    
    
    //MARK: -Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        // Do any additional setup after loading the view.
        
        titleMovies.text = movieCell?.title
        dateMovies.text = movieCell?.release_date
        descriptionTxt?.text = movieCell?.overview
        configureGenersId()
        genersTxt.text = genero
        
        titulo = movieCell?.title
        descricao = movieCell?.overview
        imagem = movieCell?.poster_path
        dataMovie = movieCell?.release_date
        
        status = false
        
        detailImage.kf.indicatorType = .activity
        //let stringImage = movie?.poster_path
        guard let stringImage = movieCell?.poster_path else {return}
        let Image = "\(URL_IMG)\(stringImage)" ?? ""
        if let image = URL(string: Image){
            detailImage.kf.indicatorType = .activity
            detailImage.kf.setImage(with: image)
        }
        
        //configureComponents()
    }
    
    func configureGenersId(){
        switch(movieCell?.genre_ids![0]){
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
        default:
            genero = "Unknow"
        }
    }
    
    @IBAction func favoriteBtnPressed(_ sender: Any) {
        self.save { (complete) in
            if complete {
                favoriteBtn.isSelected = true
                self.EmptyTextField(text: "Adicionado", message: "Este filme foi adicionado aos favoritos!")
            }
        }
    }
    
    //MARK: - COREDATA SAVE
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let movie = MovieEntity(context: managedContext)
        
        movie.movieDescription = descricao
        movie.movieTitle = titulo
        movie.movieDate = dataMovie
        movie.movieImage = imagem
        
        do {
            try managedContext.save()
            print("Successfully saved data.")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            self.EmptyTextField(text: "Pay Atention", message: error.localizedDescription)
            completion(false)
        }
    }
    
    func EmptyTextField(text: String, message: String?){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true) }
    
}
