//
//  MoviesTableViewController.swift
//  ConcreteApiMovie
//
//  Created by Israel3D on 18/09/2018.
//  Copyright © 2018 Israel3D. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    @IBOutlet weak var viewError: UIView!
    
    var movies: [MoviesResults] = []
    var currentPage: Int = 1
    var totalPage: Int = 1
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesUserDefaults().clearUserDefaults()
        loadMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    func loadMovies(){
        startLoading()
        MoviesAPI.loadMovies(page: currentPage) { (info) in
            if let info = info {
                self.movies += info.results
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
                FavoritesUserDefaults().addPageMovie(movie: currentPage)
                loadMovies()
            }
        }
    }
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! DetailsViewController
        vc.movie = movies[tableView.indexPathForSelectedRow!.row]
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
