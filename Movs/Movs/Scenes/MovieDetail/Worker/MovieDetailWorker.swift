//
//  MovieDetailWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import Moya
import Kingfisher

class MovieDetailWorker: MovieDetailWorkingLogic {
    
    let provider = MoyaProvider<MovieService>()
    
    func fetch(movie: Movie, completion: @escaping (MovieDetailed?, UIImageView?, Error?) -> ()) {
        let url = URL(string: MovieService.baseImageURL + movie.posterPath)!
        let imageView = UIImageView(frame: .zero)
        imageView.kf.setImage(with: url)
        
        provider.request(.movieDetails(id: movie.id)) { (result) in
            switch result {
            case .success(let response):
                do {
                    let movie = try JSONDecoder().decode(MovieDetailed.self, from: response.data)
                    completion(movie, imageView, nil)
                } catch let error {
                    print(error.localizedDescription)
                }
                
            case .failure(let error):
                print(error.errorDescription!)
                completion(nil, nil, error)
            }
        }
    }
}
