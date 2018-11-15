//
//  MovieDetailView.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 10/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, MovieDetailView {
    
    // MARK: - Outlets
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieReleaseYear: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    
    // MARK: - Properties
    var presenter: MovieDetailPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    // MARK: - MovieDetailView Functions
    func showDetails(of movie: MovieDetails) {
        
        DispatchQueue.main.async {
            // Image
            self.posterImage.image = movie.posterImage
            
            // Title
            self.movieTitle.text = movie.title
            
            // Release Year
            let calendar = Calendar.current
            let components = calendar.dateComponents([Calendar.Component.year], from: movie.releaseDate)
            if let year = components.year {
                self.movieReleaseYear.text = String(describing: year)
            } else {
                self.movieReleaseYear.text = "Unavailable"
            }
            
            // Genres
            var genres = ""
            for (index, genre) in movie.genres.enumerated() {
                genres.append(genre)
                if index != movie.genres.count - 1 {
                    genres.append(", ")
                }
            }
            self.movieGenres.text = genres
            
            
            // Overview
            self.movieOverview.text = movie.overview
        }
    }
    
    
    // MARK: - Functions
    
}

