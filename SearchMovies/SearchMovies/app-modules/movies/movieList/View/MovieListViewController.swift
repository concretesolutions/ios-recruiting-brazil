//
//  MovieListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToMovieListPresenterProtocol?
    
    
    //MARK: Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        MovieListRouter.setModule(self)
    }
    
}

extension MovieListViewController : PresenterToMovieListViewProtocol {
    func returnMovies(movies: [MovieListData]) {
        
    }
}

