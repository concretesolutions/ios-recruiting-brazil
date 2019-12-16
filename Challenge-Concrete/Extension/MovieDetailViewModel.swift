//
//  MovieDetailViewModel.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 15/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation

class MovieDetailViewModel {
    
    func fetchGenreNames(by ids: [Int], completion: @escaping (_ genres: String) -> Void) {
        fetchGenres { result in
            switch result {
            case .success(let response):
                var genresString = ""
                ids.forEach { id in
                    if let genre = response.genres.first(where: {$0.id == id}) {
                        genresString.append("\(genre.name), ")
                    }
                }
                genresString.removeLast(2)
                completion(genresString)
            case .failure:
                completion("Unknown")
            }
        }
    }
    
    func getGenres(_ movie: Movie) -> String {
        var genresString = ""
        movie.genreIds?.forEach { id in
            if let genre: GenreLocal = CoreDataManager.fetchBy(id: id) {
                genresString.append("\(genre.name ?? ""), ")
            }
        }
        if genresString.count > 2 {
            genresString.removeLast(2)
        }
        return genresString
    }
    
    func getGenres(_ movie: FavoriteMovie) -> String {
        var genresString = ""
        
        movie.genres?.forEach({ genre in
            print("GENRE: \(genre)")
            if let genre = genre as? GenreLocal {
                genresString.append("\(genre.name ?? ""), ")
            }
        })
        if genresString.count > 2 {
            genresString.removeLast(2)
        }
        
        return genresString
    }
    
    private func fetchGenres(completion: @escaping (Result<GenreResponse, NetworkError>) -> Void) {
        let apiProvider = APIProvider<Genre>()
        apiProvider.request(EndPoint.getGenres, completion: completion)
    }

}
