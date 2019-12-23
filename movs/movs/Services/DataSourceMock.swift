//
//  DataSourceMock.swift
//  movsSnapshotTests
//
//  Created by Emerson Victor on 18/12/19.
//  Copyright © 2019 emer. All rights reserved.
//
// swiftlint:disable line_length

import UIKit

final class DataSourceMock: DataSource {
    
    private static var collectionState: CollectionState = .loading
    
    static func setup(for state: CollectionState) {
        self.collectionState = state
    }
    
    static func fetchGenres(completion: @escaping (Result<GenresDTO, Error>) -> Void) {
        switch self.collectionState {
        case .loading, .normal, .filtered:
            return
        case .loadSuccess:
            let genresDTO = GenresDTO(genres: [
                GenreDTO(id: 28, name: "Action"),
                GenreDTO(id: 53, name: "Thriller"),
                GenreDTO(id: 12, name: "Adventure"),
                GenreDTO(id: 24, name: "Action")
            ])
            
            completion(.success(genresDTO))
        case .loadError:
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    static func fetchPopularMovies(of page: Int, completion: @escaping (Result<MoviesRequestDTO, Error>) -> Void) {
        switch self.collectionState {
        case .loading, .normal, .filtered:
            return
        case .loadSuccess:
            let moviesDTO = [MovieDTO(id: 241251,
                                      title: "The Boy Next Door",
                                      releaseDate: "2015-01-23",
                                      synopsis: "A recently cheated on married woman falls for a younger man who has moved in next door, but their torrid affair soon takes a dangerous turn.",
                                      posterPath: nil,
                                      genreIDs: [53]),
                             MovieDTO(id: 291805,
                                      title: "Now You See Me 2",
                                      releaseDate: "2016-06-02",
                                      synopsis: "One year after outwitting the FBI and winning the public’s adulation with their mind-bending spectacles, the Four Horsemen resurface only to find themselves face to face with a new enemy who enlists them to pull off their most dangerous heist yet.",
                                      posterPath: nil,
                                      genreIDs: [28, 12, 35]),
                             MovieDTO(id: 324668,
                                      title: "Jason Bourne",
                                      releaseDate: "2016-07-27",
                                      synopsis: "The most dangerous former operative of the CIA is drawn out of hiding to uncover hidden truths about his past.",
                                      posterPath: nil,
                                      genreIDs: [28, 53])]
            let movieRequestDTO = MoviesRequestDTO(page: 1,
                                                   movies: moviesDTO,
                                                   totalResults: 1,
                                                   totalPages: 1)
            completion(.success(movieRequestDTO))
        case .loadError:
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    static func fetchMoviePoster(with imageURL: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        switch self.collectionState {
        case .loading, .normal, .filtered:
            return
        case .loadSuccess:
            completion(.success(UIImage()))
        case .loadError:
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
    
    static func fetchMovieDetail(with id: Int, completion: @escaping (Result<MovieDetailDTO, Error>) -> Void) {
        switch self.collectionState {
        case .loading, .normal, .filtered:
            return
        case .loadSuccess:
            let movieDetail = MovieDetailDTO(id: id,
                                             title: "Fight Club",
                                             releaseDate: "1999-10-12",
                                             synopsis: "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground fight clubs forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
                                             posterPath: nil,
                                             genres: [GenreDTO(id: 24, name: "Action")])
            completion(.success(movieDetail))
        case .loadError:
            let error = NSError(domain: "error", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}
