//
//  Constants.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import Foundation

struct ConstUrl {

    struct Cells {
        static let moviesCellId = "movieCell"
    }

    static func url(page: String) -> String {
        return "urlListMovies".localized() + page
    }

    static func urlGenres() -> String {
        return "urlListGenres".localized()
    }

    static func urlImage(image: String) -> String {
        return "https://image.tmdb.org/t/p/w500\(image)"
    }
}
