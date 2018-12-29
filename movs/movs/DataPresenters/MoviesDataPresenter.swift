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
    func getMovies(completion: @escaping ([Movie]) -> Void, error: @escaping () -> Void) {
        service.retrieveData(endpoint: Constants.Integration.popularMoviesEndpoint,
                             completion: { data in
                if let encodedData = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
                    completion(encodedData.results)
                } else {
                    error()
                }
        }) {
            error()
        }
    }

    func getGenres(completion: @escaping ([Genre]) -> Void, error: @escaping () -> Void) {
        service.retrieveData(endpoint: Constants.Integration.genresEndpoint,
                             completion: { data in
                if let encodedData = try? JSONDecoder().decode(GenresResponse.self, from: data) {
                    completion(encodedData.genres)
                } else {
                    error()
                }
        }) {
            error()
        }
    }
}
