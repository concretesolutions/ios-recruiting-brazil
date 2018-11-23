//
//  MoviesViewController.swift
//  Movies
//
//  Created by Renan Germano on 19/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, MoviesView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movies: MoviesCollectionView!
    
    
    // MARK: - Properties
    
    var presenter: MoviesPresentation!
    var delegate: MoviesCVDelegate!
    var dataSource: MoviesCVDataSource!
    var searchDelegate: MoviesSearchBarDelegate!

    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = MoviesCVDelegate(presenter: self.presenter)
        self.movies.delegate = self.delegate
        
        self.dataSource = MoviesCVDataSource(collectionView: self.movies, presenter: self.presenter)
        self.movies.dataSource = self.dataSource
        
        self.searchDelegate = MoviesSearchBarDelegate(presenter: self.presenter)
        self.searchBar.delegate = self.searchDelegate
        
        self.navigationItem.title = "Movies"
        self.showActivityIndicator()
        
        self.presenter.viewDidLoad()
        
    }
    
    // MARK: - MoviesView protocol functions
    
    func present(movies: [Movie]) {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
            self.dataSource.update(movies: movies)
        }
    }
    
    func presentNew(movies: [Movie]) {
        DispatchQueue.main.async {
            self.dataSource.add(movies: movies)
        }
    }
    

}
