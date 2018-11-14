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
    
    override func viewWillAppear(_ animated: Bool) {
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        movies = MovieDAO.readAllFavoriteMovies()
        self.tableView.reloadData()
        
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
        // #warning Incomplete implementation, return the number of rows
        return self.movies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "favoriteMovieTableViewCell", for: indexPath) as! FavoriteMovieTableViewCell
        
        cell.setupCell(backdropImage: UIImage(named: "theMegPoster")!, title: movies[indexPath.row].title, detail: movies[indexPath.row].overview, release: movies[indexPath.row].release_date)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(self.movies[indexPath.row].title)
        
        if let viewController = UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "selectedMovieViewController") as? SelectedMovieTableViewController {
            
            viewController.movie = self.movies[indexPath.row]
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
    }

}
