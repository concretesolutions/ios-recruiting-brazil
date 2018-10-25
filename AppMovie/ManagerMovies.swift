//
//  ManagerMovies.swift
//  AppMovie
//
//  Created by Renan Alves on 25/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class ManagerMovies: UIViewController {

    var favorites = [NSDictionary]()
    var movies = [NSDictionary]()
    
    init() {
        super.init(nibName: "", bundle: nil)
        self.setupMovies()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMovies() {
        MovieDAO.shared.requestMovies(completion: { (moviesJSON) in
            if let _movies = moviesJSON {
                self.movies = _movies
            } else {
                print("Nothing movies")
            }
        })
    }
}
extension ManagerMovies: FavoriteMovieDelegate {
    
    func setFavorite(movie: NSDictionary) {
        self.favorites.append(movie)
    }
    
    func removeFavorite(movie: NSDictionary) {
        let index = getIndexFavorite(movie: movie)
        if  index != -1{
            self.favorites.remove(at: index)
        }
    }
    
    private func getIndexFavorite(movie: NSDictionary) -> Int {
        for (index, _movie) in favorites.enumerated() {
            let _id = _movie[KeyAccesPropertiesMovieNowPlaying.id.value] as? Int
            let id = movie[KeyAccesPropertiesMovieNowPlaying.id.value] as? Int
            if  _id == id {
                return index
            }
        }
        return -1
    }
}
