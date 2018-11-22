//
//  FavoriteMoviesViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {
    
    let screen = FavoriteMoviesScreen()
    
    var movies:[CDMovie] = []
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Favorites"
        let tabBarItem = UITabBarItem(title: "Favorites", image: UIImage.icon.favorite, selectedImage: UIImage.icon.favorite)
        self.tabBarItem = tabBarItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchPersistedMovies()
        super.viewWillAppear(animated)
    }

}

extension FavoriteMoviesViewController{
    
    func fetchPersistedMovies(){
        self.movies = CDMovieDAO.getAll()
//        self.screen.setupTableView(withMovies: movies)
        self.screen.tableView.setupTableView(with: movies)
    }
    
}
