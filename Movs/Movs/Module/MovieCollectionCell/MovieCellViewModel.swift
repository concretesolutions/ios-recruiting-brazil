//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    private var movie: Movie
    
    let titleText: String
    var posterImage: UIImage?
    var isLoadingPoster: Bool = true // TODO: add placeholder image
    
    init(with movie: Movie) {
        self.movie = movie
        self.titleText = movie.title
    }
    
    func fetchPoster(completion: @escaping MoviePosterCompletionBlock) {
        self.isLoadingPoster = true
        // TODO: fetch poster from URL
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoadingPoster = false
            self.posterImage = UIImage(named: "stevenPoster")
            // TODO: if poster retrival fails, retrun placeholder image
            completion(self.posterImage!)
        }
    }
}
