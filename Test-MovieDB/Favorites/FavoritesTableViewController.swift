//
//  FavoritesTableViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UIViewController {
    
    @IBOutlet weak var favoritesTableView: FavoriteMoviesTableView!
    @IBOutlet weak var searchBar: MySearchBar!
    var middle: FavoriteMoviesMiddle!
    var movieDetailWorker: MovieDetailWorker!
    var detailMiddle: MovieDetailMiddle!
    var indexToBePassed: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Movies"
        navigationController?.navigationBar.barTintColor = Colors.yellowNavigation.color
        
        middle = FavoriteMoviesMiddle(delegate: self)
        middle.fetchFavorites()
        
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        searchBar.delegate = self
        
        self.tabBarController?.tabBar.isHidden = false
        
        setupFilterButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        middle.fetchFavorites()
        if middle.quantityOfFavorites == 0 {
            alertNoItemsToBeFetched()
        }
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailMovies" {
            let vc = segue.destination as! MovieDetailViewController
            detailMiddle = MovieDetailMiddle(delegate: vc)
            vc.middle = detailMiddle
            vc.middle.favoriteMoviesMiddle = middle
            vc.middle.indexOfMovie = indexToBePassed
            self.detailMiddle.movieToLoad = sender as? MovieDetailWorker
        } else if segue.identifier == "filter" {
            let vc = segue.destination as! FilterViewController
            vc.delegate = self
            vc.middle = FilterMiddle(delegate: vc)
        }
    }
    
    func alertNoItemsToBeFetched() {
        let alert = UIAlertController(title: "Favorite movies", message: "You don't have any favorite movie", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }
    
    func setupFilterButton() {
        let filterButton = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(filter))
        self.navigationItem.rightBarButtonItem = filterButton
    }
    
    @objc func filter() {
        self.performSegue(withIdentifier: "filter", sender: String())
    }
    
}

extension FavoritesTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return favoritesTableView.frame.height / 4
    }
}

extension FavoritesTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return middle.quantityOfFavorites
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favorite", for: indexPath) as! PopularMoviesTableViewCell
        cell.configure(with: middle.movieData(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let toBeDeleted = middle.favorites[indexPath.row]
            middle.delete(movie: toBeDeleted)
            middle.fetchFavorites()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        if searchBar.text?.isEmpty == true {
            let movie = middle.favorites[indexPath.row]
            indexToBePassed = indexPath.row
            movieDetailWorker = MovieDetailWorker(posterPath: movie.posterPath, title: movie.title ?? "", genreID: movie.genreID ?? "", yearOfRelease: movie.yearOfRelease ?? "", isFavorite: true, description: movie.movieDescription ?? "", id: Int(movie.id))
            performSegue(withIdentifier: "detailMovies", sender: movieDetailWorker)
        } else {
            let movie = middle.favorites[indexPath.row]
            indexToBePassed = indexPath.row
            movieDetailWorker = MovieDetailWorker(posterPath: movie.posterPath, title: movie.title ?? "", genreID: movie.genreID ?? "", yearOfRelease: movie.yearOfRelease ?? "", isFavorite: true, description: movie.movieDescription ?? "", id: Int(movie.id))
            performSegue(withIdentifier: "detailMovies", sender: movieDetailWorker)
        }
    }
}

extension FavoritesTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            middle.filteringData(searchString: searchText)
        } else {
            middle.fetchFavorites()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if searchBar.text?.isEmpty == false {
            middle.filteringData(searchString: searchBar.text ?? "A")
        } else {
            middle.fetchFavorites()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        middle.fetchFavorites()
    }
    
    
}

extension FavoritesTableViewController: FavoriteMoviesMiddleDelegate {
    
    func favoritesFetched() {
        if middle.quantityOfFavorites == 0 {
            alertNoItemsToBeFetched()
        }
        favoritesTableView.reloadData()
    }
    
    func savedMovie() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func deletedMovie() {
        favoritesTableView.reloadData()
        if middle.quantityOfFavorites == 0 {
            alertNoItemsToBeFetched()
        }
    }
}

extension FavoritesTableViewController: FilterViewControllerDelegate {
    
    func didApplyFilter(with id: Int?, and period: Int?) {
        self.middle.filterByPeriodAndGenre(genre: id, period: period)
    }
    
}
