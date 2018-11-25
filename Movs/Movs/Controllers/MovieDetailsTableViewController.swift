//
//  MovieDetailsTableViewController.swift
//  Movs
//
//  Created by Julio Brazil on 23/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

class MovieDetailsTableViewController: UITableViewController {
    var movie: Movie
    
    init(presenting movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        self.title = "Movie"
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.title = "Movie"
    }
}
