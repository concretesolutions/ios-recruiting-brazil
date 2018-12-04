//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    class var identifier: String {
        return "MovieDetailViewController"
    }
    
    class func defaultDetailViewController() -> MovieDetailViewController {
        let view = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: identifier) as! MovieDetailViewController
        return view
    }

    @IBOutlet weak var imageLoadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var presenter: MovieDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(self)
        self.navigationItem.title = "Movie"
    }

    @IBAction func favoriteTapped(_ sender: UIButton) {
        sender.isUserInteractionEnabled = false
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            presenter.favorite()
        } else {
            presenter.unfavorite()
        }
        sender.isUserInteractionEnabled = true
    }
}

//MARK: - MovieDetailViewProtocol
extension MovieDetailViewController: MovieDetailViewProtocol {
    func set(movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = movie.releaseDate.yearString
        overviewLabel.text = movie.overview
        favoriteButton.isSelected = movie.isFavorite
        let genres = GenrePersistanceHelper.getGenre().filter {movie.genreIds.contains(Int($0.id))}
        genreLabel.text = genres.compactMap{String(safeValue: $0.name)}.joined(separator: ", ")
        imageLoadingIndicator.startAnimating()
        imageView
            .sd_setImage(with: ImageServiceConfig
                .defaultURL(with: movie.posterPath,
                            width: Int(self.imageView.frame.size.width))) { (image, _, _, _) in
            if let image = image {
                self.imageView.image = image.proportionalResized(width: self.imageView.frame.size.width)
            }
            self.imageLoadingIndicator.stopAnimating()
        }
    }
}
