//
//  FavoriteMoviesTableViewController.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 13/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import UIKit

class FavoriteMoviesTableViewController: UITableViewController {
    
    var movies: [Movie] = []
    var filteredMovies = [Movie]()
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden = false
        
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
//        var genre = Genre.init(id: 21, name: "Action")
//
//        var genreArray = [genre]
//
//        var movie = Movie.init(vote_count: 20, id: 12345, video: false, vote_average: 2, popularity: 2, genre_ids: [1, 2] , title: "The Meg", poster_path: "theMegPoster", release_date: "2018", overview: "Overview")
//
//        for i in 1...10{
//            self.movies.append(movie)
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering(){
            return self.filteredMovies.count
        }else{
            return self.movies.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "favoriteMovieTableViewCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        
        
        if isFiltering(){
            
            cell.setupCell(backdropImage: UIImage(named: "theMegPoster")!, title: filteredMovies[indexPath.row].title, detail: filteredMovies[indexPath.row].overview, release: filteredMovies[indexPath.row].release_date)
            
        } else {
            
            cell.setupCell(backdropImage: UIImage(named: "theMegPoster")!, title: movies[indexPath.row].title, detail: movies[indexPath.row].overview, release: movies[indexPath.row].release_date)
            
        }
    
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.movies[indexPath.row].title)
        
        if let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "selectedMovieViewController") as? SelectedMovieTableViewController {
            
            
            if isFiltering(){
                viewController.movie = self.filteredMovies[indexPath.row]
            }else{
                viewController.movie = self.movies[indexPath.row]
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
        }
        
    }

}

extension FavoriteMoviesTableViewController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchController.searchBar.text!)

    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMovies = movies.filter({( movie : Movie) -> Bool in
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}
