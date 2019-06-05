//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Gabriel Pereira on 02/06/19.
//  Copyright © 2019 Gabriel Pereira. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController {
    @IBOutlet weak var imageViewPoster: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieYear: UILabel!
    @IBOutlet weak var labelMovieGenre: UILabel!
    @IBOutlet weak var labelMovieDescription: UILabel!
    
    private lazy var requester = MoviesDetailsRequester()
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
        getListOfGenres()
    }
    
    func getListOfGenres() {
        requester.getGenresList(path: APIData.mountPathForRequest(path: APIData.Endpoints.genresList), responseRequest: { data in
            if let genres = data.genres {
                self.labelMovieGenre.text = self.setGenresForMovie(genres: genres)
            }
        })
    }
    
    func setGenresForMovie(genres: [Genre]) -> String {
        guard let genresIdentifiers = movie?.genres else { return String() }
        var movieGenres = String()
        
        for (index, identifier) in genresIdentifiers.enumerated() {
            for genre in genres {
                guard let genreName = genre.name else { return String() }
                
                if identifier == genre.id {
                    if index < genresIdentifiers.count - 1 {
                        movieGenres += "\(genreName), "
                    } else {
                        movieGenres += "\(genreName)"
                    }
                }
            }
        }
        
        return movieGenres
    }
    
    func renderDataOfMovie() {
        if let movie = self.movie {
            setDataForMovie(movie: movie)
            self.navigationItem.title = movie.title
        }
    }
    
    func setDataForMovie(movie: Movie) {
        if let image = URL(string: APIData.imagePath + movie.image!) {
            imageViewPoster.sd_setImage(with: image, completed: nil)
        }
        
        if let title = movie.title {
            labelMovieTitle.text = title
        }
        
        if let year = movie.releaseDate {
            let index = year.index(year.startIndex, offsetBy: 4)
            
            labelMovieYear.text = String(year.prefix(upTo: index))
        }
        
        if let description = movie.description {
            labelMovieDescription.text = description
        }
    }
}
