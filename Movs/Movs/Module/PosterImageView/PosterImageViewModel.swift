//
//  PosterImageViewModel.swift
//  Movs
//
//  Created by Bruno Barbosa on 28/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class PosterImageViewModel {
    private let movie: Movie
    private let baseImgUrl = "https://image.tmdb.org/t/p/w500"
    private var imageUrl: URL
    
    private(set) var posterImage: UIImage = UIImage(named: "poster_placeholder")!
    private(set) var isLoadingPoster: Bool = true
    
    
    init(with movie: Movie) {
        self.movie = movie
        
        self.imageUrl = URL(string: baseImgUrl + movie.posterPath)!
    }
    
    func fetchPoster(completion: @escaping MoviePosterCompletionBlock) {
        // TODO: cache image
        self.isLoadingPoster = true
        
        self.getData(from: self.imageUrl) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.isLoadingPoster = false
                if let image = UIImage(data: data) {
                    self.posterImage = image
                }
                completion(self.posterImage)
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
