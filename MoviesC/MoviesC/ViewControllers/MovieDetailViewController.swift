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
    var detail: Detail? {
        didSet {
            setupContent()
        }
    }
    
    let client = MovieAPIClient()
    var favMovies = [Int]()
    var isFav: Bool = false {
        didSet {
            navButtonIsFull(isFav)
        }
    }
    

    @IBOutlet weak var backdropImageView: UIImageView! {
        didSet {
            guard let movie = movie, let backdrop = movie.backdropPath else { return }
            let url = MovieAPIClient.imageURL(with: backdrop)
            Nuke.loadImage(with: url, into: backdropImageView)
        }
    }
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            guard let movie = movie else { return }
            let url = MovieAPIClient.imageURL(with: movie.posterPath)
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.5)), into: posterImageView)
            posterImageView.applyDropshadow()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    
    // MARK: iOS Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = movie?.title

        loadFavorites()
        loadDetail()
    }
    
    @IBAction func favoriteTapped(_ sender: UIBarButtonItem) {
        guard let id = movie?.id else { return }
        isFav = !isFav
        favorite(movie: id)
        
    }

    private func favorite(movie id: Int) {
        if isFav {
            favMovies.append(id)
        } else {
            guard let index: Int = favMovies.firstIndex(of: id) else { return }
            favMovies.remove(at: index)
        }
        
        UserDefaults.standard.set(favMovies, forKey: "favMovies")
    }
    
    private func loadFavorites() {
        if let array = UserDefaults.standard.array(forKey: "favMovies") as? [Int] {
            favMovies = array
            guard let id = movie?.id else { return }
            isFav = favMovies.contains(id) ? true : false
        }
    }
    
    func navButtonIsFull(_ state: Bool) {
        self.navigationItem.rightBarButtonItem?.image = state ? UIImage(named: "full_icon") : UIImage(named: "favorite_empty_icon")
    }
    
    
    private func loadDetail() {
        let activityIndicator = displayActivityIndicator(on: view)
        guard let id = movie?.id else { return }
        client.fetchMovie(with: id) { response in
            self.removeActivityIndicator(activityIndicator)
            switch response {
                
            case .success(let detail):
                self.detail = detail
                
            case .failure( _):
                print("Error fetching detail")
            }
        }
    }
    
    private func names(of genres: [Genre]) -> [String] {
        return genres.map { $0.name }
    }
    
    private func setupContent() {
        overviewLabel.text = detail?.overview
        titleLabel.text = movie?.title
        guard let genres = detail?.genres, let releaseDate = movie?.releaseDate else { return }
        genresLabel.text = names(of: genres).joined(separator: " | ")
        yearLabel.setYear(from: releaseDate)
    }
    
}
