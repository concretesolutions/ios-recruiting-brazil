//
//  GenreViewModel.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 16/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation
import UIKit
import Combine

final class GenreViewModel {
    public static let shared = GenreViewModel.init()
    
    //TODO: Change
    private let urlPathGenre: String = {
        return "\(ServiceAPIManager.PathsAPI.rootAPI)\(ServiceAPIManager.PathsAPI.versionAPI)\(ServiceAPIManager.PathsAPI.GenreAPI.genre)"
    }()
    
    public var genres: [Genre] = []
    
    public let notification = PassthroughSubject<Void, Never>()
    
    private init() {
        fetchAllGenres()
    }
    
    //TODO: Change
    private func fetchAllGenres() {
        guard var components = URLComponents.init(string: urlPathGenre) else { return }
        components.queryItems = [
            URLQueryItem.init(name: ServiceAPIManager.PathsAPI.apiKey, value: ServiceAPIManager.PathsAPI.key),
        ]
        guard let url = components.url else { return }
        ServiceAPIManager.get(url: url) { (data, error) in
            guard let result = data else { return }
            do {
                let genresJson = try JSONDecoder().decode(GenresAPI.self, from: result)
                self.genres = genresJson.genres
                self.notification.send()
            } catch {}
        }
    }
    
    public func filterGenres(withIDs ids: [Int]) -> [Genre] {
        return genres.filter { ids.contains($0.id)}
    }
}
