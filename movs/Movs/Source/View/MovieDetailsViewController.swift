//
//  MovieDetailsViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 19/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, BaseViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    let isFavoriteImage = UIImage(named: "favorite_full_icon")!
    let isNotFavoriteImage = UIImage(named: "favorite_gray_icon")!
    var movie: Movie!
    var presenter: MoviesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesPresenter(vc: self)
        titleLabel.text = movie.title
        descriptionLabel.text = movie.overview
        yearLabel.text = String(movie.date.split(separator: "-")[0])
        let genreNames = presenter.getGenres(for: movie)
        genresLabel.text = genreNames.joined(separator: " / ")
        movie.isFavorite = presenter.isFavorite(movie)
        updateLayout()
        guard let imagePath = movie.imagePath else { return }
        setImage(with: imagePath)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        guard let moviesVC = parent?.children.first as? MoviesCollectionViewController else { return }
        moviesVC.presenter.setFavorites()
    }
    
    private func setImage(with path: String) {
        imageView.clipsToBounds = true
        let url = URL(string: "https://image.tmdb.org/t/p/w500/")!.appendingPathComponent(path)
        URLSession.shared
            .dataTask(with: url) { (data, response, error) in
                guard error == nil else {
                    print(error!)
                    return
                }
                let capacity = 500 * 1024 * 1024
                let urlCache = URLCache(memoryCapacity: capacity, diskCapacity: capacity, diskPath: "diskPath")
                URLCache.shared = urlCache
                DispatchQueue.main.async {
                    self.imageView.image = UIImage(data: data!)
                }
            }
            .resume()
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        if movie.isFavorite {
            presenter.unfavorite(movie)
        } else {
            presenter.markAsFavorite(movie)
        }
        updateLayout()
    }
    
    func updateLayout() {
        favoriteImageView.image = movie.isFavorite ? isFavoriteImage : isNotFavoriteImage
        favoriteButton.setTitle(movie.isFavorite ? "Unlike" : "Like", for: .normal)
    }
    
    func showErrorLayout() {
        
    }

}
