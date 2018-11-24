//
//  FavoriteMoviesViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

protocol FilterApplier:class{
    func applyFilter(withYears years:[String], andGenres genres:[String])
}

final class FavoriteMoviesViewController: UIViewController {
    
    let screen = FavoriteMoviesScreen()
    var movies:[CDMovie] = []
    var isFiltering = false
    
    init(){
        super.init(nibName: nil, bundle: nil)
        self.title = "Favorites"
        let tabBarItem = UITabBarItem(title: "Favorites", image: UIImage.icon.favorite, selectedImage: UIImage.icon.favorite)
        self.tabBarItem = tabBarItem
        
        setupNavbarButton()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        self.isFiltering = false
        super.viewWillDisappear(animated)
    }
    
    func setupNavbarButton(){
        let filter = UIBarButtonItem(image: UIImage.icon.filter, style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItems = [filter]
    }
    
    @objc func filterTapped(){
        let filterManagerVC = FilterManagerViewController()
        filterManagerVC.delegate = self
        self.navigationController?.pushViewController(filterManagerVC, animated: true)
    }
    
}

extension FavoriteMoviesViewController{
    
    func fetchPersistedMovies(){
        if !isFiltering{
            self.movies = CDMovieDAO.getAll()
            self.screen.tableView.setupTableView(with: movies)
        }
    }
    
}

extension FavoriteMoviesViewController: FilterApplier{
    
    func applyFilter(withYears years: [String], andGenres genres: [String]) {
        self.isFiltering = true
        var filteredMovies = self.movies
        
        if years.count > 0{
            filteredMovies = filteredMovies.filter { (movie) -> Bool in
                years.contains(movie.getYear())
            }
        }
        
        if genres.count > 0{
            filteredMovies = filteredMovies.filter { (movie) -> Bool in
                for genre in movie.genres!{
                    if genres.contains(genre){
                        return true
                    }
                }
                return false
            }
        }
        
        self.screen.tableView.setupTableView(with: filteredMovies)
    }
    
}
