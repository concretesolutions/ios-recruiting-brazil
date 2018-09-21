//
//  MoviesTableViewController.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var movies: [MoviesResults] = []
    var currentPage: Int = 1
    var totalPage: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesUserDefaults().clearUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMovies()
    }

    func loadMovies(){
        MoviesAPI.loadMovies(page: currentPage) { (info) in
            if let info = info {
                self.movies += info.results
                self.totalPage = info.total_pages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseMoviesCell", for: indexPath) as! MoviesTableViewCell
        let movie = movies[indexPath.row]
        cell.prepareCell(withMovie: movie)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = movies.count-1
        if indexPath.row == lastItem {
            if !(currentPage > totalPage) {
                currentPage += 1
                loadMovies()
            }
        }
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        vc.movie = movies[tableView.indexPathForSelectedRow!.row]
     }
 
}
