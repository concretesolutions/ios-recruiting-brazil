//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesController: UIViewController{

    var _movies = [Dictionary<String,Any>]()
    var movies = [Movie]()
    var moviesFavorites = [Movie]()
    let dataSource = MoviesCollectionViewDataSource()
    var delegate: SendFavoritesFilmesDelegate?
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwloadMovies()
        delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        delegate?.send(favorites: moviesFavorites)
    }
    
    //MARK: Privates Methods
    private func donwloadMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self._movies = _movies
                self.transformDictionary(moviesJSON: self._movies)
                self.setupCollectionView()
                self.collectionView.reloadData()
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
    
    private func setupCollectionView() {
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        dataSource.datas = movies
        dataSource.controller = self
    }
}

//MARK: - Delegates

extension MoviesController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "DescriptionMovie", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "description")
        if let _vc = vc as? DescriptionMovieViewController {
            _vc.movie = movies[indexPath.row]
            self.present(_vc, animated: true, completion: nil)
        }
    }
}

extension MoviesController: FavoriteMovieDelegate {
    func setFavorite(movie: Movie) {
        self.moviesFavorites.append(movie)
    }
    
    func removeFavorite(movie: Movie) {
        let index = getIndexFavorite(movie: movie)
        if  index != -1 {
            self.moviesFavorites.remove(at: index)
        }
    }
    
    private func getIndexFavorite(movie: Movie) -> Int {
        for (index, _movie) in moviesFavorites.enumerated() {
            let _id = _movie.movie?.id
            let id = movie.movie?.id
            if  _id == id {
                return index
            }
        }
        return -1
    }
}

extension MoviesController: SendFavoritesFilmesDelegate {
    func send(favorites: [Movie]) {
        
    }
}
