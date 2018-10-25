//
//  ViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 21/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesController: UIViewController{

    var movies = [NSDictionary]()
    var moviesFavorites = [NSDictionary]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    let dataSource = MoviesCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donwloadMovies()
        
    }
    
    private func donwloadMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self.movies = _movies
                self.setuCollectionView()
            } else {
                print("Nothing movies")
            }
        })
    }
    
    private func setuCollectionView() {
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource
        dataSource.datas = movies
        dataSource.controller = self
    }
}
extension MoviesController: FavoriteMovieDelegate {
    
    func setFavorite(movie: NSDictionary) {
        self.moviesFavorites.append(movie)
    }
    
    func removeFavorite(movie: NSDictionary) {
        let index = getIndexFavorite(movie: movie)
        if  index != -1{
            self.moviesFavorites.remove(at: index)
        }
    }
    
    private func getIndexFavorite(movie: NSDictionary) -> Int {
        for (index, _movie) in moviesFavorites.enumerated() {
            let _id = _movie[KeyAccesPropertiesMovieNowPlaying.id.value] as? Int
            let id = movie[KeyAccesPropertiesMovieNowPlaying.id.value] as? Int
            if  _id == id {
                return index
            }
        }
        return -1
    }
}
