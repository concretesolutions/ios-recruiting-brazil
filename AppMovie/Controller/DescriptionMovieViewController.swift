//
//  DescriptionMovieViewController.swift
//  AppMovie
//
//  Created by Renan Alves on 27/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class DescriptionMovieViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imgPoster: UIImageView!

    let dataSource = TableViewDataSource()
    var movie: MovieNowPlaying?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
        setupTableView()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    //Mark: - Setups
    private func setupTableView() {
        self.tabBarController?.tabBar.isHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
        dataSource.controller = self
    }
    
    private func setupMovie() {
        self.imgPoster.image = self.movie?.backdropPath
        if let _movie = movie {
            dataSource.controller = self
            tableView.dataSource = dataSource
            dataSource.movie = _movie
            dataSource.identifierCell = "descriptionCell"
        }
    }
}

//Mark: - Delegates
extension DescriptionMovieViewController: FavoriteDelegate {
    func setFavorite(movie: MovieNowPlaying) {
        ManagerMovies.shared.moviesFavorites.append(movie)
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.movies)
        ManagerMovies.shared.movies[index].updateFavorite()
        self.dataSource.datas = ManagerMovies.shared.movies
        self.dataSource.movie = movie
        self.tableView.reloadData()
    }
    
    func removeFavorite(movie: MovieNowPlaying) {
        let index = Index.getIndexInArray(movie: movie, at: ManagerMovies.shared.moviesFavorites)
        if  index != -1 {
            ManagerMovies.shared.moviesFavorites.remove(at: index)
            ManagerMovies.shared.movies[index].updateFavorite()
            self.dataSource.datas = ManagerMovies.shared.movies
            self.dataSource.movie = movie
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
    }
    
}
