//
//  MovieDetailViewController.swift
//  ConcreteTMDb
//
//  Created by Pedro Del Rio Ortiz on 22/11/18.
//  Copyright © 2018 Pedro Ortiz. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - Actions
    
    @IBAction func favoriteMovie(_ sender: Any) {
        
        // Save movie on Core Data
        
        if let movie = self.movieCell?.movie {
            self.coreDataManager.createFavoriteMovie(with: movie)
        }
        
        // Animate Button
        
        self.OutletFavoriteButton.setImage(UIImage(named: "favoriteOn"), for: .normal)
        
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var OutletMovieImage: UIImageView!
    @IBOutlet weak var OutletMovieName: UILabel!
    @IBOutlet weak var OutletMovieYear: UILabel!
    @IBOutlet weak var OutletMovieOverView: UILabel!
    @IBOutlet weak var OutletFavoriteButton: UIButton!
    
    // MARK: - Properties
    
    let coreDataManager = CoreDataManager()
    var movieCell: MoviesCollectionViewCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        
        if let movie = self.movieCell?.movie {

            self.OutletMovieName.text = movie.title
            self.OutletMovieYear.text = movie.date
            self.OutletMovieOverView.text = movie.overview
            
            if let image = self.movieCell?.OutletMovieImage.image {
                self.movieCell?.movie?.image = image
                self.OutletMovieImage.image = image
            }
            
            
        }
        
        
    }
    
}
