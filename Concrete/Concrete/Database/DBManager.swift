//
//  DBManager.swift
//  Concrete
//
//  Created by Vinicius Brito on 21/04/19.
//  Copyright © 2019 Vinicius Brito. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {

    private var database: Realm
    static let sharedInstance = DBManager()

    private init() {
        database = try! Realm()
    }

    func registerGenres(genres: Genres) {
        try! database.write {
            let objectsRealmList = List<Genre>()

            for object in genres.genres {
                objectsRealmList.append(object)
            }

            database.add(objectsRealmList, update: true)
        }
    }

    func getGenreName(by id: Int) -> String {
        let results = database.objects(Genre.self).filter("id == \(id)")
        if let string = results.first?.name {
                return string
        }

        return ""
    }

    //Bookmarks
    func getBookmarkItens() -> [MovieViewModel] {
        let results = database.objects(MovieViewModel.self).filter("isBookmarked == true")
        let movies = Array(results)
        return movies
    }

    func checkBookmarkedItem(movie: MovieViewModel) -> Bool {
        let object = getDBObject(movie: movie)
        if object.isBookmarked == true {
            return true
        }

        return false
    }

    func changeState(movie: MovieViewModel) {
        if checkBookmarkedItem(movie: movie) {
            deleteItem(movie: movie)
        } else {
            addItem(movie: movie)
        }
    }

    func changeStateAndCheck(movie: MovieViewModel) -> Bool {
        changeState(movie: movie)
        return checkBookmarkedItem(movie: movie)
    }

    private func getDBObject(movie: MovieViewModel) -> MovieViewModel {
        let pKey = movie.idMovie
        let result = database.object(ofType: MovieViewModel.self, forPrimaryKey: pKey)
        if result != nil {
            return result!
        } else {
            registerItem(movie: movie)
            return getDBObject(movie: movie)
        }
    }

    private func registerItem(movie: MovieViewModel) {
        try! database.write {
            database.add(movie, update: true)
        }
    }

    private func addItem(movie: MovieViewModel) {
        let object = getDBObject(movie: movie)
        try! database.write {
            object.isBookmarked = true
            database.add(object, update: true)
        }
    }

    private func deleteItem(movie: MovieViewModel) {
        let object = getDBObject(movie: movie)
        try! database.write {
            object.isBookmarked = false
            database.add(object, update: true)
        }
    }
}
