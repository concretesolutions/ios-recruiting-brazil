//
//  FavoritesTableViewController.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    
    var movies: [MoviesResults] = []
    var favoriteMovies: [MoviesResults] = []
    var moviesIds: [Int] = []
    var currentPage: Int = 1
    var totalPage: Int = 0
    var activityIndicator = UIActivityIndicatorView()
    let favoriteMoviesUserDefaults = FavoritesUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {

        totalPage =  FavoritesUserDefaults().getPage()
        for _ in 1...totalPage{
            loadMovies()
            if !(currentPage>totalPage) {currentPage += 1}
        }
        currentPage = 1
        moviesIds = favoriteMoviesUserDefaults.showFavoritesMovie()
    }

    func loadMovies(){
        startLoading()
        movies = []
        favoriteMovies = []
        MoviesAPI.loadMovies(page: currentPage) { (info) in
            if let info = info {
                print(self.moviesIds)
                self.movies += info.results
                self.favoriteMovies = self.movies.filter({ (data) -> Bool in
                                            self.moviesIds.contains(data.id);
                                        })
                
                self.totalPage = info.total_pages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.stopLoading()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseFavoriteCell", for: indexPath) as! FavoritesTableViewCell
        let movie = favoriteMovies[indexPath.row]
        cell.prepareCell(withMovie: movie)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Unfavorite") { (action, indexPath) in
            let movieUnfavoriteUserDefaults = FavoritesUserDefaults()
            let index = indexPath.row
            movieUnfavoriteUserDefaults.removeFavoriteMovie(index: index)
            self.favoriteMovies.remove(at: index)
            self.moviesIds.remove(at: index)
            self.movies.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [delete]
    }
    
    // MARK: - Loading
    func startLoading() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopLoading(){
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
