//
//  DefaultGenresRepository.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import GenericNetwork

class DefaultGenresRepository<GenresProviderType: ParserProvider>: GenresRepository where GenresProviderType.ParsableType == [String: [Genre]] {
    
    private let genresProvider: GenresProviderType
    
    init(genresProvider: GenresProviderType) {
        self.genresProvider = genresProvider
    }
    func getAllGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
        genresProvider.requestAndParse(route: TMDBMoviesRoute.genres) { (result) in
            switch result {
            case .success(let genresDictionary):
                completion(.success(genresDictionary["genres"]!))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
