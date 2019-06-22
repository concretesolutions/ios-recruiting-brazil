//
//  MoviesGenresModel.swift
//  Movs
//
//  Created by Filipe Merli on 21/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import Foundation

final class MoviesGenresModel {
    private var genres: [Genres] = []
    
    let client = TheMovieDBClient()
    
    func findGen(from id: Int) -> String {
        for index in 0..<genres.count  {
            if genres[index].id == id {
                return genres[index].name
            }
        }
        return ""
    }
    
    func fetchMoviesGenres() {
        client.fetchMoviesGenres() { result in
            switch result {
            case .failure(let error):
                print("Error find genres")
//                DispatchQueue.main.async {
//                    self.delegate?.onFetchFailed(with: error.reason)
//                }
            case .success(let response):
                DispatchQueue.main.async {
                    self.genres.append(contentsOf: response.genres)
                }
            }
        }
    }
    
}

