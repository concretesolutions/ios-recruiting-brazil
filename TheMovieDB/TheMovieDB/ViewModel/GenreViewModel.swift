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
    private var genreService = GenreService.init()
    public var genres: [Genre] = []
    public let notification = PassthroughSubject<Void, Never>()
    
    private init() {
        requestGenres()
    }
    
    public func loadAllGenres() {
        GenreAdapter.getAllGenres { (genres) in
            guard let returnGenres = genres else { return }
            self.genres = returnGenres
            self.notification.send()
        }
    }
    
    public func filterGenres(withIDs ids: [Int]) -> [Genre] {
        return genres.filter { (genre) -> Bool in
            guard let genreID = genre.idGenre else { return false }
            return ids.contains { (value) -> Bool in
                return "\(value)" == genreID
            }
        }
    }
    
    public func requestGenres() {
        self.genreService.fetchGenres { (genres) in
            for genre in genres {
                GenreAdapter.saveGenre(genre)
            }
        }
        loadAllGenres()
    }
}
