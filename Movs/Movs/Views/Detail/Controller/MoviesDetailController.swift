
//
//  DetailController.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import UIKit
import Kingfisher
import CoreData

class MoviesDetailController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovieLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var genresLbl: UILabel!
    @IBOutlet weak var overviewTxView: UITextView!
    @IBOutlet weak var favoritedBtn: UIButton!
    
    //MARK: Properties
    var imageUrl = ""
    var titleMovie = ""
    var date = ""
    var movieId: Int = 0
    var overView = ""
    var idMovie = ""
    
    var idMovieDB = [String]()
    var genreMovie = [Int]()
    var resultGenre = Detail()
    var favoritesDB = [Favorites]()
    
    //MARK: ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchRequest()
        loadData(id: movieId)
        favoritedBtn.addTarget(self, action: #selector(favorited(_:)), for: .touchUpInside)
    }
    
}

//MARK: Functions
extension MoviesDetailController {
    
    func setup() {
        navigationItem.title = "Details"
        nameMovieLbl.text = titleMovie
        releaseDateLbl.text = date
        overviewTxView.text = overView
        let url = URL(string: Network.shared.imageUrl + imageUrl)
        imageMovie.kf.setImage(with: url)
        imageMovie.layer.cornerRadius = 5
        imageMovie.layer.masksToBounds = true
    }
    
    func fetchRequest() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        do {
            favoritesDB = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Favorites]
            for favorite in favoritesDB {
                idMovieDB.append((favorite).value(forKey: "id") as! String)
            }
        } catch{}

        for movie in idMovieDB {
            if movie == idMovie {
                favoritedBtn.setImage(UIImage(named: "favorited"), for: .normal)
            }
        }
    }
    
    func loadData(id: Int) {
        if Reachability.isConnectedToNetwork() {
            
            let funcSucesso = { (item: Detail?) -> Void  in
                
                self.resultGenre.genres = item?.genres
                var listGenre = [String]()
                for genre in self.resultGenre.genres! {
                    for idGenre in self.genreMovie {
                        if genre.id == idGenre {
                            if let genre = genre.name {
                                listGenre.append(genre)
                            }
                        }
                    }
                }
                
                let stringRepresentation = listGenre.joined(separator: ", ")
                self.genresLbl.text = stringRepresentation
            }
            
            let funcError = { (item: Detail?) -> Void in
                print("erro")
            }
            
            Network.shared.getDetailOfMovie(movieId: id, funcSucesso: funcSucesso, funcError: funcError)
            
        } else {
            
        }
    }
    
    @objc
    func favorited(_ sender: UIButton) {
        if sender.currentImage == UIImage(named: "notFavorited") {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
            
            do {
                favoritesDB = try CoreDataStack.managedObjectContext.fetch(fetchRequest) as! [Favorites]
                
                let title = self.nameMovieLbl?.text
                let date = self.releaseDateLbl?.text
                let genre = self.genresLbl?.text
                let overview = self.overviewTxView?.text
                let imgBanner = self.imageUrl
                let id = self.idMovie
                
                if #available(iOS 10.0, *) {
                    let favoritesDB = Favorites(context: CoreDataStack.managedObjectContext)
                    favoritesDB.title = title
                    favoritesDB.release_date = date
                    favoritesDB.genre = genre
                    favoritesDB.overview = overview
                    favoritesDB.poster_path = imgBanner
                    favoritesDB.id = id
                }
                CoreDataStack.saveContext()
                sender.setImage(UIImage.init(named: "favorited"), for: .normal)
            }catch{}
        } else {
            let alert = UIAlertController(title: "Attencion!", message: "This movie is already a favorite", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

