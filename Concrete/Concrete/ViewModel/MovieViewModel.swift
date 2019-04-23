//
//  MovieViewModel.swift
//  Concrete
//
//  Created by Vinicius Brito on 20/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class MovieViewModel: Object {
    @objc dynamic var title: String?
    @objc dynamic var image: String?
    @objc dynamic var year: String?
    @objc dynamic var genres: String?
    @objc dynamic var synopsis: String?
    @objc dynamic var idMovie: Int = 0
    @objc dynamic var isBookmarked = false

    convenience init(item: Result) {
        self.init()
        title = item.title
        image = item.posterPath
        year = setYear(date: item.releaseDate)
        genres = setGenres(ids: item.genreIDS ?? [])
        synopsis = item.overview
        idMovie = item.idMovie ?? 0
    }

    override class func primaryKey() -> String? {
        return "idMovie"
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

    private func setYear(date: String?) -> String {
        if let dat = date {
            return dat[0..<4]
        }

        return "2019"
    }
}

class Person: Object {
    @objc dynamic var name = ""
    @objc dynamic var picture = ""
}
