//
//  TMDBMovieService.swift
//  Movs
//
//  Created by Bruno Barbosa on 26/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import Foundation

class TMDBMovieService: MovieServiceProtocol {
    private init() {}
    static private(set) var shared: MovieServiceProtocol = TMDBMovieService()
    
    private(set) var popularMovies: [Movie] = []
    private(set) var favoriteMovies: [Movie] = []
    
    private func urlFor(path: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.themoviedb.org"
        urlComponents.path = "/3\(path)"
        let apiKeyItem = URLQueryItem(name: "api_key", value: "fc6b049905f30ded698536f6721cc0b1")
        urlComponents.queryItems = [apiKeyItem]
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        print("URL:", url)
        return url
    }
    
    func fetchPopularMovies(completion: @escaping MoviesListCompletionBlock) {
        let url = self.urlFor(path: "/movie/popular")
        let request = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            DispatchQueue.main.async {
                if let _ = responseError {
                    completion(.requestFailed, [])
                } else if let jsonData = responseData {
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(APIResponse.self, from: jsonData)
                        self.popularMovies = response.results
                        completion(nil, self.popularMovies)
                    } catch {
                        completion(.requestFailed, [])
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchFavoriteMovies(completion: @escaping MoviesListCompletionBlock) {
        // TODO: implement API request
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.favoriteMovies = [
                // TODO: get favorite movies from local disk
            ]
            completion(nil, self.favoriteMovies)
        }
    }
    
    func toggleFavorite(for movie: Movie, completion: SuccessOrErrorCompletionBlock?) {
        // TODO: save favorite status
        if (movie.isFavorite) {
            self.favoriteMovies.removeAll { (curMovie) -> Bool in
                curMovie.id == movie.id
            }
        } else {
            self.favoriteMovies.append(movie)
        }
        
        movie.isFavorite = !movie.isFavorite
        NotificationCenter.default.post(name: .didUpdateFavoritesList, object: self)
        
        // call calback with success status and/or error
        completion?(true, nil)
    }
}

/*func fetchPopularMovies(completion: @escaping MoviesListCompletionBlock) {
    // TODO: implement API request
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.popularMovies = [
            Movie(withTitle: "Steve Universe: The Movie", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: false),
            Movie(withTitle: "Steve Universe Future", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: false),
            Movie(withTitle: "Steve Universe", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.", isFavorite: true),
            Movie(withTitle: "Steve", andPoster: "stevenPoster", andReleaseDate: "2019-10-18", andGenreIds: [80, 19, 53], andOverview: "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours.")
        ]
        completion(nil, self.popularMovies)
    }
}*/
