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
    func showDetails(of movie: Movie) {
        // Assuming that the image from the MovieCell was just a thumbnail, we should now fetch the full size image
        ImageDataManager.getImageFrom(imagePath: movie.posterPath, completion: { (image) in
            DispatchQueue.main.async {
                self.posterImage.image = image
            }
        })
    }
    
    
    // MARK: - Functions
    
}

