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

    let dataSource = FavoriteTableViewDataSource()
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMovie()
    }
    
    private func setupMovie() {
        self.imgPoster.image = self.movie?.movie?.backdropPath
        if let _movie = movie {
            tableView.dataSource = dataSource
            tableView.delegate = self
            dataSource.movie = _movie
            dataSource.identifierCell = "descriptionCell"
        }
    }
}
extension DescriptionMovieViewController: UITableViewDelegate {
    
}
