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
    var searchedMovies = [Movie]()
    var filteredMovies = [Movie]()
    @IBOutlet weak var clearFiltersButtonOutlet: UIBarButtonItem!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchImageView = UIImageView()
    var searchLabel = UILabel()
    var hasAddedSearchImage: Bool = false
    var searchText = ""
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Checks for any filtered movies
        if isFiltering(){
            print("Vai rolar um filtro")
            for movie in self.movies{
                if FilterManager.shared.genders.contains(where: { (genre) -> Bool in
                    for movieGender in movie.genre_ids{
                        if genre.id == movieGender{
                            return true
                        }
                    }
                    return false
                }){
                    if self.filteredMovies.contains(where: { (comparedMovie) -> Bool in
                        if comparedMovie.title == movie.title{
                            return true
                        }
                        return false
                    }){
                        print("Esse filme ja existe no vetor, muito provavelmente proveniente de outro filtor.")
                    }else{
                        self.filteredMovies.append(movie)
                    }
                    
                }
                
                if FilterManager.shared.releaseDates.contains(movie.release_date){
                    
                    if self.filteredMovies.contains(where: { (comparedMovie) -> Bool in
                        if comparedMovie.title == movie.title {
                            return true
                        }
                        return false
                    }){
                        print("Ja existe")
                    }else{
                        self.filteredMovies.append(movie)
                    }
                }
            }
            self.tableView.reloadData()
        }else{
           print("Nenhum filtro aplicado")
        }

        self.tabBarController?.tabBar.isHidden = false
        
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
        
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.filteredMovies = []
    }
    
    @IBAction func clearFiltersButtonTapped(_ sender: Any) {
        
        FilterManager.shared.genders.removeAll()
        FilterManager.shared.releaseDates.removeAll()
        
        self.tableView.reloadData()
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !(FilterManager.shared.releaseDates.isEmpty) || !(FilterManager.shared.genders.isEmpty){
            print("Vai rolar um filtro")
            return self.filteredMovies.count
        }
        
        if isSearching(){
            return self.searchedMovies.count
        }else{
            return self.movies.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "favoriteMovieTableViewCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        if !(FilterManager.shared.releaseDates.isEmpty) || !(FilterManager.shared.genders.isEmpty){
            
            cell.setupCell(title: filteredMovies[indexPath.row].title, detail: filteredMovies[indexPath.row].overview, release: filteredMovies[indexPath.row].release_date, posterPath: filteredMovies[indexPath.row].poster_path)
            
            return cell
            
        }
    
        if isSearching(){
            
            cell.setupCell(title: searchedMovies[indexPath.row].title, detail: searchedMovies[indexPath.row].overview, release: searchedMovies[indexPath.row].release_date, posterPath: searchedMovies[indexPath.row].poster_path)
            
        } else {
            
            cell.setupCell(title: movies[indexPath.row].title, detail: movies[indexPath.row].overview, release: movies[indexPath.row].release_date, posterPath: movies[indexPath.row].poster_path)
            
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
            }else if isSearching(){
                viewController.movie = self.searchedMovies[indexPath.row]
            }else{
                viewController.movie = self.movies[indexPath.row]
            }
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            if isSearching(){
                print(searchedMovies[indexPath.row].title)
                MovieDAO.deleteFavoriteMovie(favoriteMovie: searchedMovies[indexPath.row])
                self.searchedMovies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }else{
                print(movies[indexPath.row].title)
                MovieDAO.deleteFavoriteMovie(favoriteMovie: movies[indexPath.row])
                self.movies.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }
    
    @IBAction func filterButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Filter", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "filterViewController") as! FilterViewController
        
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    

}

extension FavoriteMoviesTableViewController: UISearchResultsUpdating, UISearchControllerDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
//        if isFiltering(){
//            
//            filteredMovies = movies.filter({ (movie: Movie) -> Bool in
//                self.searchText = searchText
//                return movie.title.lowercased().contains(searchText.lowercased())
//            })
//            tableView.reloadData()
//        }
        
        searchedMovies = movies.filter({( movie : Movie) -> Bool in
            self.searchText = searchText
            return movie.title.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool{
        
        return !FilterManager.shared.genders.isEmpty || !FilterManager.shared.releaseDates.isEmpty
        
    }
    
    func isSearching() -> Bool {
        
        if (self.searchedMovies.isEmpty == true && !searchBarIsEmpty()) && hasAddedSearchImage == false {
            print("Sua busca não retornou resultados")
            
            let searchText = "Sua busca por \"" + self.searchText + "\" não retornou resultados"
            self.searchLabel.text = searchText
            self.searchLabel.textAlignment = .center
            self.searchLabel.frame.size = CGSize(width: 300, height: 150)
            self.searchLabel.numberOfLines = 3
            self.searchLabel.center = self.tableView.center
            
            let searchImage = UIImage(named: "search_icon.png")
            self.searchImageView = UIImageView(image: searchImage)
            self.searchImageView.frame.size = CGSize(width: 100, height: 100)
            self.searchImageView.center.x = self.tableView.center.x
            self.searchImageView.center.y = self.tableView.center.y - 100
            self.tableView.addSubview(searchImageView)
            self.tableView.addSubview(searchLabel)
            hasAddedSearchImage = true
            
        }
        
        if (self.searchedMovies.isEmpty == false && !searchBarIsEmpty()) && hasAddedSearchImage == true {
            self.searchImageView.removeFromSuperview()
            self.hasAddedSearchImage = false
            self.searchLabel.removeFromSuperview()
        }
        
        
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        print("Dismiss")
        
        if self.hasAddedSearchImage == true {
            self.searchImageView.removeFromSuperview()
            self.searchLabel.removeFromSuperview()
        }
        
    }
    
}
