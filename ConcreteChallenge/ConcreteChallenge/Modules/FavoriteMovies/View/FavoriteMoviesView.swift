//
//  FavoriteMoviesView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController, FavoriteMoviesView {
    
    // MARK: - Outlets
    @IBOutlet weak var favoriteMoviesTableView: FavoriteMoviesTableView!
    
    // MARK: - Properties
    var presenter: FavoriteMoviesPresentation!
    
    // MARK: - Life cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        
        self.presenter.didRequestFavoriteMovies()
    }
    
    // MARK: - FavoriteMoviesView Functions
    func show(favoriteMovies: [Movie]) {
        for movie in favoriteMovies {
            print(movie.title)
        }
    }
    
    // MARK: - Functions
    func setupNavigationBar() {
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
    }
}

