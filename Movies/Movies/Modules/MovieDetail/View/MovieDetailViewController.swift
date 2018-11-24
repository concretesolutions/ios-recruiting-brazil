//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Renan Germano on 24/11/2018.
//  Copyright © 2018 Renan Germano. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    // MARK: - Properties
    
    var presenter: MovieDetailPresentation!
    private var movie: Movie! {
        didSet {
            self.posterImage.image = self.movie.posterImage
            self.movieTitle.text = self.movie.title
            self.year.text = "\(self.movie.year)"
            var genresString = "\(self.movie.genres.first?.name ?? "")"
            for i in Range(uncheckedBounds: (1, self.movie.genres.count)) {
                genresString += ", \(self.movie.genres[i].name)"
            }
            self.genres.text = genresString
            self.overview.text = self.movie.overview
        }
    }
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - MovieDetailView protocol functions
    
    func present(movie: Movie) {
        self.movie = movie
    }

}
