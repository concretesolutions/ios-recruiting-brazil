//
//  MoviesDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift
import RealmSwift

/**
 The object representing the response of TMDB's popular movies.
 */
class PopularMovieResponse: Decodable {
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

protocol MoviesDataSource {
    func fetchPopularMovies() -> Single<[Movie]>
    func fetchFavoritedMovies() -> Single<[Movie]>
    func isMovieFavorited(_ movie: Movie) -> Bool
    func addToFavorites(_ movie: Movie) -> Completable
    func removefromFavorites(_ movie: Movie) -> Completable
}

class MoviesDataSourceImpl: MoviesDataSource {

    func fetchPopularMovies() -> Single<[Movie]> {
        return requestData(url: "\(NetworkClientConstants.baseURL)/movie/popular").map({ (data: Data) -> [Movie] in
            if let movies = self.parseMovies(data) {
                return movies
            }
            return []
        })
    }

    func fetchFavoritedMovies() -> Single<[Movie]> {
        return Single.create { observer in
            let disposable = Disposables.create {}
            DispatchQueue.global(qos: .background).async {
                guard let realm = try? Realm() else {
                    DispatchQueue.main.async {
                        observer(.error(MovErrors.genericError))
                    }
                    return
                }
                var favoritedMovies = [Movie]()
                let results = realm.objects(RealmMovieModel.self)
                for object in results {
                    favoritedMovies.append(object.toMovie())
                }
                DispatchQueue.main.async {
                    observer(.success(favoritedMovies))
                }
            }
            return disposable
        }
    }

    func addToFavorites(_ movie: Movie) -> Completable {
        return Completable.create { observer in
            DispatchQueue.global(qos: .background).async {
                guard let realm = try? Realm() else {
                    DispatchQueue.main.async {
                        observer(.error(MovErrors.genericError))
                    }
                    return
                }
                do {
                    try realm.write {
                        if !self.isMovieFavorited(movie) {
                            realm.add(RealmMovieModel(movie: movie))
                        }
                        DispatchQueue.main.async {
                            observer(.completed)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        observer(.error(MovErrors.genericError))
                    }
                }
            }
            return Disposables.create {}
        }
    }

    func removefromFavorites(_ movie: Movie) -> Completable {
        return Completable.create { observer in
            DispatchQueue.global(qos: .background).async {
                guard let realm = try? Realm() else {
                    DispatchQueue.main.async {
                        observer(.error(MovErrors.genericError))
                    }
                    return
                }
                do {
                    try realm.write {
                        if self.isMovieFavorited(movie), let object = realm.object(ofType: RealmMovieModel.self, forPrimaryKey: movie.movieId) {
                            realm.delete(object)
                        }
                        DispatchQueue.main.async {
                            observer(.completed)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        observer(.error(MovErrors.genericError))
                    }
                }
            }
            return Disposables.create {}
        }
    }

    func isMovieFavorited(_ movie: Movie) -> Bool {
        guard let realm = try? Realm() else { return false }
        return realm.object(ofType: RealmMovieModel.self, forPrimaryKey: movie.movieId) != nil
    }

    private func parseMovies(_ data: Data) -> [Movie]? {
        do {
            let response = try JSONDecoder().decode(PopularMovieResponse.self, from: data)
            return response.results
        } catch {
            return nil
        }
    }
}
