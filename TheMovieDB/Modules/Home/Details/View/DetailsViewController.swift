//
//  DetailsViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    @IBOutlet weak var movieGenrerLabel: UILabel!
    @IBOutlet weak var movieDescLabel: UILabel!
    
    // MARK: - Variables
    var viewModel: DetailsViewControllerViewModel!
    
    // MARK: - Dependencies
    var movie: MovieResponse!
    
    func configure(with movie: MovieResponse) {
        self.movie = movie
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = DetailsViewControllerViewModel(delegate: self)
        configView()
        configData()
    }
    
    private func configView() {
        title = "movie".localized
    }
    
    private func configData() {
        movieNameLabel.text = movie.title
        movieYearLabel.text = movie.releaseDate?.getYearFromDate()
        movieGenrerLabel.text = String(movie.genreIds?[0] ?? 0)
        movieDescLabel.text = movie.overview
        
        downloadImage(from: movie)
        viewModel.requestGenre(from: movie)
    }
    
    private func downloadImage(from movie: MovieResponse) {
        let endPoint = "\(API.ImageSize.w500.rawValue)\(movie.posterPath ?? "")"
        if let url = URL(string: endPoint, relativeTo: API.imageUrlBase) {
            movieImage.af_setImage(withURL: url)
        }
    }
}

// MARK: - DetailsViewControllerProtocol
extension DetailsViewController: DetailsViewControllerProtocol {
    func setMovie(genre: String) {
        movieGenrerLabel.text = genre
    }
}
