//
//  MovieViewModel.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit

class MovieViewModel {
    var title: String?
    var image: String?
    var year: String?
    var genres: String?
    var synopsis: String?

    init (item: Result) {
        title = item.title
        image = item.posterPath
        year = setYear(date: item.releaseDate)
        genres = setGenres(ids: item.genreIDS)
        synopsis = item.overview
    }

    private func setGenres(ids: [Int]) -> String {
        for idGenre in ids {
            print(idGenre)
        }

        return "Drama"
    }

    private func setYear(date: String) -> String {
        return date[0..<4]
    }
}
