//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

var favoriteMovies:[String : Bool] = [:]

class MoviesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    let screen = MoviesViewControllerScreen()
    let searchController = UISearchController(searchResultsController: nil)
    let network = RequestMovies.shared
    
    let userDefaults = SalvedDatas.shared
    var filteredMovie = [Result]()
    
    override func loadView() {
        
        self.view = screen
        self.view.backgroundColor = .white
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen.movieCollectionView.delegate = self
        screen.movieCollectionView.dataSource = self
        
        setupSearchController()
        
        loadData()
        loadFavorites()
    }
    
    func loadData(){
        network.request()
    }

    
    func loadFavorites(){
        
        if let results = network.results{
            for movie in results{
                favoriteMovies[movie.title!] = false
            }
            
            let favorites = userDefaults.favoriteMovies
            for favorite in favorites{
                if let _ = favoriteMovies[favorite]{
                    favoriteMovies[favorite] = true
                }
            }
            
            print(favoriteMovies)
        }
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        loadFavorites() //AJUSTAR, para teste, criar thread para esperar retorno do request
        
        
        if isFiltering() {
            return filteredMovie.count
        }
        
        
        if let results = network.results{
            print(results.count)
            return results.count
        }
        
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        var movie: Result
        if isFiltering() {
            movie = filteredMovie[indexPath.row]
        }else{
            movie = network.results![indexPath.row]
        }
        
        cell.backgroundColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        
        if let title = movie.title, let fav = favoriteMovies[title]{
            cell.title.text = title
            cell.favoriteButton.image = fav ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")
        }
        
        if let key = movie.posterPath{
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500" + key)!
            let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, responde, error) in
                if let error = error{
                    print(error.localizedDescription)
                }
                if let data = data {
                    DispatchQueue.main.async {
                        cell.movieImage.image = UIImage(data: data)
                    }
                }
            }
            dataTask.resume()
        }else{
            cell.movieImage.image = #imageLiteral(resourceName: "thor6")
        }
        
       
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width*0.435, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        toMovieDetails(row: indexPath.row)
    }
    
    func toMovieDetails(row: Int) {
        let movieDetails = MovieDetailsViewController()
        movieDetails.view.backgroundColor = .white
        movieDetails.moviesViewController = self
        
        
        if isFiltering() {
            movieDetails.movie = filteredMovie[row]
        }else{
            if let results = network.results{
                movieDetails.movie = results[row]
            }
        }
        
        self.navigationController?.pushViewController(movieDetails, animated:
            true)
        
    }
    
    func reloadCollectionView(){
        screen.movieCollectionView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
}

extension MoviesViewController: UISearchResultsUpdating {
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.tintColor = UIColor(red:0.18, green:0.19, blue:0.27, alpha:1.00)
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)

    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        if let results = network.results{
            filteredMovie = results.filter({( movie : Result) -> Bool in
                return movie.title!.lowercased().contains(searchText.lowercased())
            })
        }
        
        screen.movieCollectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}

