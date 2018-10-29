//
//  InitialViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 28/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var header: UIView!
    @IBOutlet weak var containerMovies: UIView!
    @IBOutlet weak var containerFavorites: UIView!
    @IBAction func changeViewMode(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 1:
            self.view.bringSubviewToFront(containerFavorites)
        default:
            self.view.bringSubviewToFront(containerMovies)
            
        }
        
    }
    
    var _movies = [Dictionary<String,Any>]()
    var movies = [Movie]()
    var moviesFavorites = [Movie]()
    var movieController: MoviesController?
    var favoriteController: FavoritesViewController?
    var sendDataDelegate: SendDataDelegate?
    var updateFavoriteDelegate: SendDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwloadMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let moviesController = segue.destination as? MoviesController, segue.identifier == "segueMovies" {
            moviesController.movies = movies
            moviesController.dadController = self
            self.movieController = moviesController
            sendDataDelegate = moviesController
        }else if let favoriteController = segue.destination as? FavoritesViewController, segue.identifier == "segueFavorites" {
            favoriteController.favorites = moviesFavorites
            self.favoriteController = favoriteController
            self.favoriteController?.dadController = self
            updateFavoriteDelegate = favoriteController
        }
    }
    
    //MARK: Privates Methods
    private func donwloadMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self._movies = _movies
                self.transformDictionary(moviesJSON: self._movies)
                self.view.bringSubviewToFront(self.containerMovies)
                self.sendDataDelegate?.send(data: self.movies)
            } else {
                print("Nothing movies")
            }
        })
    }
    
    private func transformDictionary(moviesJSON: [Dictionary<String,Any>]) {
        for movie in moviesJSON {
            self.movies.append(Movie(_movieNP: movie))
        }
    }
    
}
//MARK: - Delegates

extension InitialViewController: FavoriteMovieDelegate {
    func setFavorite(movie: Movie) {
        self.moviesFavorites.append(movie)
        self.updateFavoriteDelegate?.send(data: moviesFavorites)
    }
    
    func removeFavorite(movie: Movie) {
        let index = Index().getIndexInArray(movie: movie, at: moviesFavorites)
        if  index != -1 {
            self.moviesFavorites.remove(at: index)
            let _indexMovie = Index().getIndexInArray(movie: movie, at: movies)
            if _indexMovie != -1 {
                self.movies[_indexMovie].updateFavorite()
                self.movieController?.collectionView.reloadData()
            }
        }
        self.updateFavoriteDelegate?.send(data: moviesFavorites)
    }
    
}

extension InitialViewController: SendFavoritesFilmesDelegate {
    func send(favorites: [Movie]) {
        
    }
}
