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
    
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            guard let movie = movie else { return }
            let url = movie.posterUrl()
            Nuke.loadImage(with: url, options: ImageLoadingOptions(transition: ImageLoadingOptions.Transition.fadeIn(duration: 0.5)), into: posterImageView)
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
        
        loadDetail()
    }
    
    @IBAction func favoriteTapped(_ sender: UIBarButtonItem) {
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
        genresLabel.text = names(of: genres).joined(separator: ", ")
        yearLabel.text = getYear(from: releaseDate)
    }
    
}
