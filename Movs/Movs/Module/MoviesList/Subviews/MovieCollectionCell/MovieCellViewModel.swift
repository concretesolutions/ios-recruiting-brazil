//
//  MovieCellViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieCellViewModel {
    private(set) var movie: Movie
    
    let titleText: String
    private(set) var posterImage: UIImage = UIImage(named: "stevenPoster")! // TODO: add placeholder image
    private(set) var isLoadingPoster: Bool = true
    
    init(with movie: Movie) {
        self.movie = movie
        self.titleText = movie.title
    }
    
    func fetchPoster(completion: @escaping MoviePosterCompletionBlock) {
        self.isLoadingPoster = true
        // TODO: fetch poster from URL
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoadingPoster = false
            if let image = UIImage(named: "stevenPoster") {
                self.posterImage = image
            }
            completion(self.posterImage)
        }
    }
}
