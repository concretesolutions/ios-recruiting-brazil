//
//  MovieCell.swift
//  MoviesC
//
//  Created by Isabel Lima on 02/12/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import Nuke

class MovieCell: UICollectionViewCell {
    
    var movie: Movie? {
        didSet {
            guard let movie = movie else { return }
            let url = posterUrl(path: movie.posterPath)
            Nuke.loadImage(with: url, into: posterImageView)
            titleLabel.text = movie.title
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func posterUrl(path: String) -> URL {
        guard let configuration = APISettings.shared.configuration else {
            return URL(string: "https://image.tmdb.org/t/p/w500/")!.appendingPathComponent(path)
        }
        
        guard let baseImageURL = URL(string: configuration.images.baseURL) else {
            //TODO: Show error screen
            fatalError("Invalid base URL supplied by API")
        }
        // TODO: choose poster size (maybe implement an enum with possible values)
        guard let imageSize = configuration.images.posterSizes.first else {
            //TODO: Implement "image unavailable" default image
            fatalError("No image sizes available")
        }
        
        let url = baseImageURL.appendingPathComponent(imageSize).appendingPathComponent(path)
        
        return url
        
    }
    
}
