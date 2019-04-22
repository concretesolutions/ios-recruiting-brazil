//
//  MovieViewModel.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit
import Realm

class MovieViewModel {
    var title: String?
    var image: String?
    var year: String?
    var genres: String?
    var synopsis: String?
    var idMovie: Int?

    init (item: Result) {
        title = item.title
        image = item.posterPath
        year = setYear(date: item.releaseDate)
        genres = setGenres(ids: item.genreIDS ?? [])
        synopsis = item.overview
        idMovie = item.idMovie
    }

    private func setGenres(ids: [Int]) -> String {
        if !ids.isEmpty {
                var stringGenres = DBManager.sharedInstance.getGenreName(by: ids.first!)

                for index in 1..<ids.count {
                    stringGenres += ", \(DBManager.sharedInstance.getGenreName(by: ids[index]))"
                }

            return stringGenres
        }

        return ""
    }

    private func setYear(date: String) -> String {
        return date[0..<4]
    }
}
