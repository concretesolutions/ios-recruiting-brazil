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
    
    var isFavorite: Bool {
        return self.movieService.isFavorite(movie: self.movie)
    }
    
    private var imageUrl: URL
    private var movieService: MovieServiceProtocol
    
    init(with movie: Movie, andService service: MovieServiceProtocol) {
        self.movie = movie
        self.titleText = movie.title
        self.movieService = service
        let baseImgUrl = "https://image.tmdb.org/t/p/w500"
        imageUrl = URL(string: baseImgUrl + movie.posterPath)!
    }
    
    func fetchPoster(completion: @escaping MoviePosterCompletionBlock) {
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
