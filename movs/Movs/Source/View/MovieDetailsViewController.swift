//
//  MovieDetailsViewController.swift
//  movs
//
//  Created by Lorien Moisyn on 19/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController, MoviesViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    let isFavoriteImage = UIImage(named: "favorite_full_icon")!
    let isNotFavoriteImage = UIImage(named: "favorite_empty_icon")!
    var movie: Movie!
    var presenter: FavoritesPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FavoritesPresenter(vc: self)
        titleLabel.text = movie.title
//        yearLabel.text = movie.
        movie.isFavorite = presenter.isFavorite(movie)
        guard let imagePath = movie.imagePath else { return }
        setImage(with: imagePath)
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
    }
    
    func updateLayout() {
        favoriteImageView.image = presenter.isFavorite(movie) ? isFavoriteImage : isNotFavoriteImage
    }

}
