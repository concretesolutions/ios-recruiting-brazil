//
//  MovieCollectionViewCell.swift
//  Movie
//
//  Created by Gustavo Pereira Teixeira Quenca on 19/07/19.
//  Copyright © 2019 Gustavo Pereira Teixeira Quenca. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var date: UILabel!
    var downloadTask: URLSessionDownloadTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    // Cancel the pending download
    override func prepareForReuse() {
        super.prepareForReuse()
        downloadTask?.cancel()
        downloadTask = nil
    }
    
    //MARK: -Configure the view for Movies
    func configure(for result: Movie) {
        
        if let releaseDate = result.release_date {
            // Get only the year
            let index = releaseDate.index(releaseDate.startIndex, offsetBy: 4)
            date.text = String(releaseDate.prefix(upTo: index))
        }
        
        if let title = result.title {
            titleLabel.text = title
        }
        
        if let posterPath = result.poster_path {
            let urlImage = "https://image.tmdb.org/t/p/w200\(posterPath)"
            posterImage.image = UIImage(named: urlImage)
            posterImage.layer.cornerRadius = 10.0
            if let smallURL = URL(string: urlImage) {
                downloadTask = posterImage.loadImage(url: smallURL)
            }
        }
    }
}
