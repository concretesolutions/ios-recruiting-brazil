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
            if movie.genres.count > 1 {
                for i in Range(uncheckedBounds: (1, self.movie.genres.count)) {
                    genresString += ", \(self.movie.genres[i].name)"
                }
            }
            self.genres.text = genresString
            self.overview.text = self.movie.overview
        }
    }
    private let favoriteEmptyIcon = UIImage(named: "favorite_empty_icon")
    private let favoriteFullIcon = UIImage(named: "favorite_full_item_icon")
    private var favoriteButton: UIBarButtonItem!
    
    // MARK: - Life cicle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }
    
    // MARK: - Aux functions
    
    private func setFavoriteButton() {
        
        self.favoriteButton = UIBarButtonItem(image: self.movie.isFavorite ? self.favoriteFullIcon : self.favoriteEmptyIcon, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.didTappFavoriteButton))
        
        self.navigationItem.rightBarButtonItem = self.favoriteButton
        
    }
    
    // MARK: - MovieDetailView protocol functions
    
    func present(movie: Movie) {
        self.movie = movie
        self.setFavoriteButton()
    }
    
    // MARK: - Actions
    
    @objc func didTappFavoriteButton() {
        self.presenter.didTapFavoriteButton(forMovie: self.movie)
        self.favoriteButton.image = self.movie.isFavorite ? self.favoriteFullIcon : self.favoriteEmptyIcon
    }

}
