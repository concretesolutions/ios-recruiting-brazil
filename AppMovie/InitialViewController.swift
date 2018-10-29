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
    @IBOutlet weak var containerEmptyState: UIView!
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
    var movies = [MovieNowPlaying]()
    var moviesFavorites = [MovieNowPlaying]()
    var movieController: MoviesController?
    var favoriteController: FavoritesViewController?
    var sendDataDelegate: SendDataDelegate?
    var updateFavoriteDelegate: SendDataDelegate?
    var activityIndicator : UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView()
        
        activity.center = CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
        activity.hidesWhenStopped = true
        activity.style = UIActivityIndicatorView.Style.gray
        return activity
    }()
    var viewLoad: UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        view.backgroundColor = .gray
        view.alpha = 0.5
        view.tag = 999
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bringSubviewToFront(containerEmptyState)
        self.view.addSubview(viewLoad)
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        setupMovies()
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
    private func setupMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self._movies = _movies
                self.transformDictionary(moviesJSON: self._movies)
                self.view.bringSubviewToFront(self.containerMovies)
                self.sendDataDelegate?.send(data: self.movies)
                self.activityIndicator.stopAnimating()
                self.view.bringSubviewToFront(self.containerMovies)
                self.removeViewLoad()
            } else {
                print("Nothing movies")
            }
        })
    }
    
    private func removeViewLoad() {
        if let view = self.view.viewWithTag(999) {
            view.removeFromSuperview()
        }
    }
    
    private func transformDictionary(moviesJSON: [Dictionary<String,Any>]) {
        for movie in moviesJSON {
            self.movies.append(MovieNowPlaying(_movieNP: movie))
        }
    }
    
}

//MARK: - Delegates
extension InitialViewController: FavoriteMovieDelegate {
    func setFavorite(movie: MovieNowPlaying) {
        self.moviesFavorites.append(movie)
        let index = Index.getIndexInArray(movie: movie, at: movies)
        self.movies[index].updateFavorite()
        self.movieController?.dataSource.datas = movies
        self.updateFavoriteDelegate?.send(data: moviesFavorites)
    }
    
    func removeFavorite(movie: MovieNowPlaying) {
        let index = Index.getIndexInArray(movie: movie, at: moviesFavorites)
        if  index != -1 {
            self.moviesFavorites.remove(at: index)
            let _indexMovie = Index.getIndexInArray(movie: movie, at: movies)
            if _indexMovie != -1 {
                self.movies[_indexMovie].updateFavorite()
                self.movieController?.dataSource.datas = movies
                self.movieController?.collectionView.reloadData()
            }
        }
        self.updateFavoriteDelegate?.send(data: moviesFavorites)
    }
}

extension InitialViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let resultSearch = movies.filter({$0.originalTitle.prefix(searchText.count) ==  searchText })
        movieController?.dataSource.datas = resultSearch
        movieController?.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        movieController?.dataSource.datas = movies
        movieController?.collectionView.reloadData()
    }
}
