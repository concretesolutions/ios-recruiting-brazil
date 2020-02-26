//
//  MovieDetailPresenter.swift
//  ios-challenge-moviedb
//
//  Created by Giovanni Severo Barros on 24/02/20.
//  Copyright © 2020 Giovanni Severo Barros. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailViewDelegate {
}

class MovieDetailPresenter {
    
    var movieView: MovieDetailViewDelegate?
    weak var delegate: MovieDetailPresenterDelegate?
    
    init() {
        
    }
    
    func getMovieImageURL(width: Int, path: String) -> URL? {
        let imageURL = ImagesEndpoint.movieImage(width: width, path: path).imageUrl
        return imageURL
    }
    
    func getGenres(ids: [Int], completion: @escaping ([String]?) -> Void) {
        var movieGenresString: [String] = []
        MovieClient.getAllGenres { (genres, error) in
            if let genres = genres {
                for id in ids {
                    for genre in genres {
                        if genre.id == id {
                            print(genre.name)
                            movieGenresString.append(genre.name)
                        }
                    }
                }
                completion(movieGenresString)
            } else {
                // tratar o erro
                completion(nil)
            }
        }
    }
}
