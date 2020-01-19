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
        self.genreService.fetchGenres { (genres) in
            self.genres = genres
            self.notification.send()
        }
    }
    
    public func filterGenres(withIDs ids: [Int]) -> [Genre] {
        return genres.filter { ids.contains($0.id)}
    }
}
