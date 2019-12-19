//
//  PersistenceService.swift
//  Movs
//
//  Created by Lucca Ferreira on 18/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import Foundation

final class PersistenceService {

    static var publisher = NotificationCenter.default.publisher(for: UserDefaults.didChangeNotification)

    static var favoriteMovies: [Int] {
        guard let array = UserDefaults.standard.array(forKey: "favoriteMovies") as? [Int] else { return [] }
        return array
    }

    class func favorite(movie: Movie) {
        var values = favoriteMovies
        if values.contains(movie.id) {
            values.removeAll { $0 == movie.id }
        } else {
            values.append(movie.id)
        }
        movie.isLiked.toggle()
        UserDefaults.standard.set(values, forKey: "favoriteMovies")
        print(favoriteMovies)
    }

}
