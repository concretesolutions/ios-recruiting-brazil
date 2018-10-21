//
//  Movie.swift
//  Challenge
//
//  Created by Sávio Berdine on 20/10/18.
//  Copyright © 2018 Sávio Berdine. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Movie {
    
    var imagePath: String?
    var name: String?
    var isFavourite: Bool?
    var date: String?
    var genre: Observable<String> = Observable<String>(value: "")
    var description: String?
    var overview: String?
    var id: Int?
    
    init() {
        
    }
    
    init(movie: [String: Any]) {
        //self.image = movie["image"]
        if let dbName = movie["title"] as? String {
            self.name = dbName
        } else {
            self.name = ""
        }
        //self.isFavourite = isFavourite
        if let dbDate = movie["release_date"] as? String {
            self.date = dbDate
        } else {
            self.date = ""
        }
        self.genre.update(with: "")
        if let genreIds = movie["genre_ids"] as? [Int] {
            if Genre.currentGenres.isEmpty {
                Genre.getCurrentGenres(onSuccess: { (genreArray) in
                    Genre.currentGenres = genreArray
                    for element in genreIds {
                        let localGenre = Genre.currentGenres.first {$0.id == element}
                        if localGenre != nil {
                            if !(self.genre.read().isEmpty) {
                                self.genre.update(with: "\(String(describing: self.genre.read())), \(String(describing: (localGenre?.name!)!))")
                            } else {
                                self.genre.update(with: "\(String(describing: (localGenre?.name!)!))")
                            }
                        }
                    }
                }) { (error) in
                    print("Error fetching genres: \(error)")
                }
            } else {
                for element in genreIds {
                    let localGenre = Genre.currentGenres.first {$0.id == element}
                    if localGenre != nil {
                        if !(self.genre.read().isEmpty) {
                            self.genre.update(with: "\(String(describing: self.genre.read())), \(String(describing: (localGenre?.name!)!))")
                        } else {
                            self.genre.update(with: "\(String(describing: (localGenre?.name!)!))")
                        }
                    }
                }
            }
        } else {
            self.genre.update(with: "")
        }
        if let dbOverview = movie["overview"] as? String {
            self.overview = dbOverview
        } else {
            self.overview = ""
        }
        self.description = ""
        if let dbId = movie["id"] as? Int {
            self.id = dbId
        } else {
            self.id = 0
        }
        if let dbImagePath = movie["poster_path"] as? String {
            self.imagePath = dbImagePath
        } else {
            self.imagePath = ""
        }
    }
    
    class func getPopularMovies(pageToRequest: Int, onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content_type": "aplication/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/movie/popular?api_key=\(Tmdb.apiKey)&language=en-US&page=\(pageToRequest)", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            guard let results = value["results"] as? [[String: Any]] else {
                onFailure("No movie results")
                return
            }
            var resultMovies: [Movie] = []
            for element in results {
                let movie = Movie(movie: element)
                //print(movie.genre)
                resultMovies.append(movie)
            }
            onSuccess(resultMovies)
        }
    }

    class func getFavoriteMovies(pageToRequest: Int, onSuccess: @escaping (_ movies: [Movie]) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content_type": "aplication/json"]
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/account/\(String(describing: User.user.userId!))/favorite/movies?api_key=\(Tmdb.apiKey)&session_id=\(String(describing: User.user.sessionId!))&sort_by=created_at.asc&language=en-US&page=\(pageToRequest)", method: .get, parameters: nil, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                print(response.result)
                onFailure("Request error requesting account details")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                onFailure("Data received is compromised")
                return
            }
            guard let results = value["results"] as? [[String: Any]] else {
                onFailure("No movie results")
                return
            }
            var resultMovies: [Movie] = []
            for element in results {
                let movie = Movie(movie: element)
                //print(movie.genre)
                resultMovies.append(movie)
            }
            onSuccess(resultMovies)
        }
    }
    
    func setFavorite(movie: Movie, setAsFavorite: Bool, onSuccess: @escaping (_ success: Any) -> Void, onFailure: @escaping (_ error: String) -> Void) {
        let headers: HTTPHeaders = ["content-type": "application/json"]
        var parameters: Parameters = [:]
        if setAsFavorite {
            parameters = [
                "media_type": "movie",
                "media_id": movie.id!,
                "favorite": 1
            ]
        } else {
            parameters = [
                "media_type": "movie",
                "media_id": movie.id!,
                "favorite": 0
            ]
        }
        
        print(parameters)
        Alamofire.request("\(Tmdb.apiRequestBaseUrl)/account/\(String(describing: User.user.userId!))/favorite?api_key=\(Tmdb.apiKey)&session_id=\(String(describing: User.user.sessionId!))", method: .post, parameters: parameters, headers: headers).validate().responseJSON { (response) in
            guard response.result.isSuccess else {
                //onFailure("Request error validating token")
                return
            }
            guard let value = response.result.value as? [String: Any] else {
                //onFailure("Data received is compromised")
                return
            }
            if let success = value["success"] as? Int {
                if success == 1 {
                    onSuccess(success)
                } else {
                    onFailure("Failed to set favorite")
                }
            } else {
                if let status = value["status_message"] as? String {
                    onFailure(status)
                } else {
                    onFailure("Data received is compromised")
                }
            }
        }
    }
    
}
