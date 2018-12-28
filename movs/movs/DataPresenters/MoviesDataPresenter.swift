//
//  MoviesDataPresenter.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import Foundation

final class MoviesDataPresenter {
    // MARK: - Properties
    private let service = Service.shared
}

// MARK: - Public
extension MoviesDataPresenter {
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        service.retrieveData(endpoint: Constants.Integration.popularMoviesEndpoint) { data in
            if let encodedData = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                completion(encodedData.results)
            } else {
                print("Something went wrong on the Serialization.")
            }
        }
    }

    func getGenres(completion: @escaping ([Genre]) -> Void) {
        service.retrieveData(endpoint: Constants.Integration.genresEndpoint) { data in
            if let encodedData = try? JSONDecoder().decode(GenresResponse.self, from: data) {
                completion(encodedData.genres)
            } else {
                print("Something went wrong on the Serialization.")
            }
        }
    }
}
