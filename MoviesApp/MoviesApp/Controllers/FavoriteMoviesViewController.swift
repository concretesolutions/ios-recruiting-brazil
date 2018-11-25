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
    var titleSearched:String?
    
    var isFiltering = false
    var filteredYears:[String] = []
    var filteredGenres:[String] = []
    
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
        setupSearchBar()
    }
    
    override func loadView() {
        screen.delegate = self
        self.view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateFavoriteMovies(movies: nil)
        super.viewWillAppear(animated)
    }
    
    func setupNavbarButton(){
        let filter = UIBarButtonItem(image: UIImage.icon.filter, style: .plain, target: self, action: #selector(filterTapped))
        self.navigationItem.rightBarButtonItems = [filter]
    }
    
    @objc func filterTapped(){
        let filterManagerVC = FilterManagerViewController()
        filterManagerVC.delegate = self
        filterManagerVC.filteredYears = self.filteredYears
        filterManagerVC.filteredGenres = self.filteredGenres
        self.navigationController?.pushViewController(filterManagerVC, animated: true)
    }
    
}

extension FavoriteMoviesViewController{
    
    func fetchPersistedMovies() -> [CDMovie]{
        return CDMovieDAO.fetchAll()
    }
    
    func updateFavoriteMovies(movies:[CDMovie]?){
        
        var updatedMovies = movies != nil ? movies! : fetchPersistedMovies()
        if let searched = self.titleSearched{
            updatedMovies = CDMovieDAO.fetchMovies(with: searched)
        }
        updatedMovies = filterMovies(movies: updatedMovies, years: self.filteredYears, genres: self.filteredGenres)
        self.movies = updatedMovies
        self.screen.tableView.setupTableView(with: updatedMovies, filtering: self.isFiltering)
        
    }
    
}

extension FavoriteMoviesViewController: FilterApplier{
    
    func applyFilter(withYears years: [String], andGenres genres: [String]) {
        self.isFiltering = !(years.count == 0 && genres.count == 0)
        
        self.filteredYears = years
        self.filteredGenres = genres
        
        updateFavoriteMovies(movies: nil)
    }
    
    func filterMovies(movies:[CDMovie], years:[String], genres:[String]) -> [CDMovie]{
        var filteredMovies = movies
        
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
        
        return filteredMovies
    }
    
}

extension FavoriteMoviesViewController: FilterResetter{
    
    func resetFilter() {
        self.filteredYears = []
        self.filteredGenres = []
        self.isFiltering = false
        updateFavoriteMovies(movies: nil)
    }
    
}

//Search Controller/Bar
extension FavoriteMoviesViewController: UISearchBarDelegate{
    
    func setupSearchBar(){
        self.definesPresentationContext = true
        let searchController = UISearchController(searchResultsController: nil)
        searchController.definesPresentationContext = true
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            if !text.isEmpty{
                var movies = CDMovieDAO.fetchMovies(with: text)
                movies = movies.filter({ (movie) -> Bool in
                    self.movies.contains(movie)
                })
                self.titleSearched = text
                updateFavoriteMovies(movies: movies)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.titleSearched = nil
        updateFavoriteMovies(movies: nil)
    }
    
}
