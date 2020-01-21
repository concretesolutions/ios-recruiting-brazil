//
//  GenreService.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 19/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

class GenreService {
    private let pathGenresURL: String = {
        return "\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.GenreAPI.genre)"
    }()

    public func fetchGenres(resultGenres: @escaping (([Genre]) -> Void)) {
        guard var components = URLComponents.init(string: pathGenresURL) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.apiKey, value: ServiceAPIManager.PathsAPI.key),
        ]
        guard let url = components.url else { return }
        ServiceAPIManager.get(url: url) { (data, error) in
            guard let result = data else { return }
            do {
                let genresJson = try JSONDecoder().decode(GenresResponse.self, from: result)
                GenreAdapter.parseGenres(genresJson.genres) { (parseResult) in
                    resultGenres(parseResult)
                }
            } catch {}
        }
    }
}
