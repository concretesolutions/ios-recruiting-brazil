//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var labelMovieGender: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    private var movie: Movie?
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: "MovieDetailsViewController", bundle: Bundle.main)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForNavigationItem()
        renderDataOfMovie()
    }
    
    func renderDataOfMovie() {
        if let movie = self.movie {
            setDataForMovie(movie: movie)
            self.navigationItem.title = movie.title
        }
    }
    
    func setDataForMovie(movie: Movie) {
        guard let image = URL(string: APIData.imagePath + movie.image!) else { return }
        
        imageViewPoster.sd_setImage(with: image, completed: nil)
        
        if let title = movie.title {
            labelMovieTitle.text = title
        }
        
        if let year = movie.releaseDate {
            labelMovieYear.text = year
        }
        
        if let description = movie.description {
            labelMovieDescription.text = description
        }
    }
}
