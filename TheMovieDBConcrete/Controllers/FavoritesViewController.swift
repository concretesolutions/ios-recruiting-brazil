//
//  FavoritesViewController.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,passFilter {
    
    // MARK: - Variables
    var favoriteMovies: Movies = Movies()
    var searchActive = false
    var filteredMovies: Movies = Movies()
    var requestHasError = false
    var advancedFilter = AdvancedFilter()
    var advancedFilterMovies: Movies = Movies()
    
    // MARK: - Outlets
    @IBOutlet weak var favoritesFilterSearchBar: UISearchBar!
    @IBOutlet weak var favoritesTableView: UITableView!
    
    //MARK: - Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        //NotificationCenter.default.addObserver(self, selector: #selector(favoriteMoviesChanged(_:)), name: NSNotification.Name(rawValue: "favoriteChanged"), object: nil)
        
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
        favoritesTableView.reloadData()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
        doAdvancedSearch()
        searchFilter(searchText: favoritesFilterSearchBar.text!)
        favoritesTableView.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func favoriteMoviesChanged(_ notification:Notification) {
        favoriteMovies = PersistenceService.retrieveFavoriteMovies()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SearchBar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchFilter(searchText: searchText)
        self.favoritesTableView.reloadData()
    }
    
    func searchFilter(searchText: String) {
        if advancedFilter.isActive {
            filteredMovies.movies = advancedFilterMovies.movies.filter({ (text) -> Bool in
                let tmp: NSString = (text.name as NSString?)!
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if searchText == "" {
                searchActive = false
            } else {
                searchActive = true
            }
        } else {
            filteredMovies.movies = favoriteMovies.movies.filter({ (text) -> Bool in
                let tmp: NSString = (text.name as NSString?)!
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            if searchText == "" {
                searchActive = false
            } else {
                searchActive = true
            }
        }
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if advancedFilter.isActive {
            if searchActive {
                return filteredMovies.movies.count
            } else {
                return advancedFilterMovies.movies.count
            }
        } else {
            return favoriteMovies.movies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath as IndexPath) as! FavoriteTableViewCell
        if advancedFilter.isActive {
            if searchActive {
                cell.movieImage.image = filteredMovies.movies[indexPath.row].backgroundImage
                cell.movieNameLabel.text = filteredMovies.movies[indexPath.row].name
                cell.movieDescriptionLabel.text = filteredMovies.movies[indexPath.row].movieDescription
                cell.yearLabel.text = filteredMovies.movies[indexPath.row].year
            } else {
                cell.movieImage.image = advancedFilterMovies.movies[indexPath.row].backgroundImage
                cell.movieNameLabel.text = advancedFilterMovies.movies[indexPath.row].name
                cell.movieDescriptionLabel.text = advancedFilterMovies.movies[indexPath.row].movieDescription
                cell.yearLabel.text = advancedFilterMovies.movies[indexPath.row].year
            }
        } else {
            cell.movieImage.image = favoriteMovies.movies[indexPath.row].backgroundImage
            cell.movieNameLabel.text = favoriteMovies.movies[indexPath.row].name
            cell.movieDescriptionLabel.text = favoriteMovies.movies[indexPath.row].movieDescription
            cell.yearLabel.text = favoriteMovies.movies[indexPath.row].year
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewControllerId") as? MovieViewController {
            if advancedFilter.isActive {
                if searchActive {
                    vc.movie = filteredMovies.movies[indexPath.row]
                } else {
                    vc.movie = advancedFilterMovies.movies[indexPath.row]
                }
            } else {
                vc.movie = favoriteMovies.movies[indexPath.row]
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            // delete item at indexPath
            PersistenceService.removeFavorite(withName: self.favoriteMovies.movies[indexPath.row].name)
            self.favoriteMovies.movies.remove(at: indexPath.row)
            self.favoritesTableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [unfavorite]
    }
    @IBAction func goToAdvancedFilter(_ sender: Any) {
        if let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "advancedFilter") as? AdvancedFilterViewController {
            vc.delegate = self
            vc.filter = self.advancedFilter
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    // MARK: - Class Functions
    @IBAction func removeFilter(_ sender: Any) {
        favoritesFilterSearchBar.text = ""
        searchActive = false
        advancedFilter = AdvancedFilter()
        self.favoritesTableView.reloadData()
    }
    
    func filterDidChange(filter: AdvancedFilter) {
        self.advancedFilter = filter
        self.advancedFilter.isActive = true
        doAdvancedSearch()
        print(advancedFilter.year)
        print(advancedFilter.genre.name)
    }
    
    func doAdvancedSearch() {
        self.advancedFilterMovies = Movies()
        if advancedFilter.isActive {
            if advancedFilter.genre.name != "" {
                print(advancedFilter.genre.name)
                for movie in favoriteMovies.movies {
                    var hasGenre = false
                    for genre in movie.genres.genresArray {
                        if genre.name == advancedFilter.genre.name {
                            hasGenre = true
                        }
                    }
                    if hasGenre {
                        self.advancedFilterMovies.movies.append(movie)
                    }
                }
            }
            if advancedFilter.year != "" {
                for movie in favoriteMovies.movies {
                    if movie.year == advancedFilter.year {
                        var alreadyOn = false
                        for singleMovie in advancedFilterMovies.movies {
                            if singleMovie == movie {
                                alreadyOn = true
                            }
                        }
                        if !alreadyOn {
                            advancedFilterMovies.movies.append(movie)
                        }
                    }
                }
            }
        }
        self.favoritesTableView.reloadData()
        
    }
    
}
