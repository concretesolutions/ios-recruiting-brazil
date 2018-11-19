//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie:Movie
    var genres:[Genre]
    var screen = DetailMovieScreen()
    
    init(movie:Movie, genres:[Genre]) {
        self.movie = movie
        self.genres = genres
        self.screen.setupTableView(with: movie, genres: genres)
        super.init(nibName: nil, bundle: nil)
        self.title = movie.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        self.view = screen
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
