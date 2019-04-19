//
//  FavoriteTableViewCell.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setup(with movie: Movie) {
        titleLabel.text = movie.title
        yearLabel.text = String(movie.date.split(separator: "-").first ?? "")
        descriptionLabel.text = movie.overview
        guard let imagePath = movie.imagePath else { return }
        setImage(with: imagePath)
    }
    
    private func setImage(with path: String) {
        movieImageView.clipsToBounds = true
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
                    self.movieImageView.image = UIImage(data: data!)
                }
            }
            .resume()
    }

}
