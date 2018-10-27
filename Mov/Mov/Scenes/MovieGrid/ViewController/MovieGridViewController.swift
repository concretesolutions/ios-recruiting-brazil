//
//  MovieListViewController.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridViewController: UIViewController {
    
    var collection: UICollectionView!
    
    let dataSource = MovieGridDataSource()
    
    var interactor: MovieGridInteractor!
    
    override func loadView() {
        let view = MovieGridView()
        self.collection = view.collection
        self.collection.dataSource = self.dataSource
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.fetchMovieList(page: 1)
    }
}

extension MovieGridViewController: MovieGridViewOutput {
    
    func display(movies: [MovieGridViewModel]) {
        self.dataSource.viewModels = movies
        
        self.collection.reloadData()
    }
    
    func displayNetworkError() {
        
    }
    
    
}
