//
//  MovieDetailViewController.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    
    var movie: Movie?
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            guard let movie = movie else { return }
            let url = movie.posterUrl()
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.5)), into: posterImageView)
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movie?.title
    }
    
}
