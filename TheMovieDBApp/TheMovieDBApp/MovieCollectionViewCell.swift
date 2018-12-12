//
//  MovieCollectionViewCell.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 02/11/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    
    var downloadTask: URLSessionDownloadTask?
    var favChecked = false
    var favListMovies = [MovieListResult]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func favMovies() {
        if favChecked {
        favButton.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
            
        } else {
        favButton.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        favChecked = true
        }
    }
    
    // Cancel the pending download
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    func configure(for result: MovieListResult) {

        titleLabel.text = result.title!
        if let posterPath = result.poster_path {
            let urlImage = "https://image.tmdb.org/t/p/w200\(posterPath)"
            posterImage.image = UIImage(named: urlImage)
            if let smallURL = URL(string: urlImage) {
                downloadTask = posterImage.loadImage(url: smallURL)
                print(smallURL)
            }
        }
    }
}
