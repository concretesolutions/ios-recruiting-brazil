//
//  Array+Extension.swift
//  TheMovieDB
//
//  Created by Renato Lopes on 16/01/20.
//  Copyright © 2020 renato. All rights reserved.
//

import Foundation

extension Array where Element == Genre {
    func descriptionAllGenres() -> String? {
        var description = ""
        for genre in self {
            description.append("/ \(genre.name)")
        }
        return description
    }
}
