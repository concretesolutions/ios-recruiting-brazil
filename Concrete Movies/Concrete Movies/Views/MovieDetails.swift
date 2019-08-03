//
//  MovieDetails.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 01/08/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit

class MovieDetails: ViewController {
    @IBOutlet weak var movieDetailsImage: UIImageView!
    @IBOutlet weak var movieDetailsTitle: UILabel!
    @IBOutlet weak var movieDetailsYear: UILabel!
    @IBOutlet weak var movieDetailsGenre: UILabel!
    @IBOutlet weak var movieDetailsOverview: UILabel!
    
    @IBAction func dismissMovieDetails(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = self.presentingViewController as! TabBarSettings
        let moviesTabVC = vc.children.first as! MoviesTabViewController
        moviesTabVC.movieDetails = self
    }
}

extension MovieDetails: MovieDetailsDelegate {
    func sendMovieDetails(_ movie: Movie) {
        movieDetailsImage.image = UIImage(data: movie.image!)
        movieDetailsTitle.text = movie.name
        movieDetailsYear.text = movie.date
        movieDetailsOverview.text = movie.details
        var text: String = ""
        movie.genre.forEach { (genre) in
            text.append(genre.name)
            text.append("\n")
        }
        movieDetailsGenre.text = text
    }
}
