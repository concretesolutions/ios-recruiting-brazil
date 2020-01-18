//
//  MoviesVC.swift
//  Movs
//
//  Created by Rafael Douglas on 18/01/20.
//  Copyright © 2020 com.rafael.douglas. All rights reserved.
//

import UIKit

class MoviesVC: UIViewController {
    var movies = [Movie]()
    var filteredMovies = [Movie]()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        getMoviesFromApi()
    }
    
    func getMoviesFromApi() {
        MovieDBApi.getPopularMovies(withPage: page, onComplete: { (movies) in
            self.movies.append(contentsOf: movies)
            self.page += 1
            print(movies)
        }, onError: { (error) in
            
        })
    }
    
    
    
}
