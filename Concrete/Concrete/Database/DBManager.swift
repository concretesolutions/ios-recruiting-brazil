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

    private func getDBObject(movie: Result) -> Result {
        let pKey = movie.idMovie
        let result = database.object(ofType: Result.self, forPrimaryKey: pKey)
        if result != nil {
            return result!
        } else {
            registerItem(movie: movie)
            return getDBObject(movie: movie)
        }
    }

    func checkBookmarkedItemFromKey(pKey: Int) -> Bool {
        let result = database.object(ofType: Result.self, forPrimaryKey: pKey)
        if let isBooked = result {
            return isBooked.isBookmarked
        } else {
            return false
        }
    }

    func changeBookmarkedItemFromKey(pKey: Int) -> Bool {
        if let result = database.object(ofType: Result.self, forPrimaryKey: pKey) {
            checkAndChangeState(movie: result)
            return checkBookmarkedItem(movie: result)
        }

        return false
    }

    func registerItem(movie: Result) {
        try! database.write {
            database.add(movie, update: true)
        }
    }

    func getBookmarkItens() -> [Result] {
        let results = database.objects(Result.self).filter("isBookmarked == true")
        let movies = Array(results)
        return movies
    }

    func checkBookmarkedItem(movie: Result) -> Bool {
        let object = getDBObject(movie: movie)
        if object.isBookmarked == true {
            return true
        }

        return false
    }

    func checkAndChangeState(movie: Result) {
        if checkBookmarkedItem(movie: movie) {
            deleteItem(movie: movie)
        } else {
            addItem(movie: movie)
        }
    }

    func addItem(movie: Result) {
        let object = getDBObject(movie: movie)
        try! database.write {
            object.isBookmarked = true
            database.add(object, update: true)
        }
    }

    func deleteItem(movie: Result) {
        let object = getDBObject(movie: movie)
        try! database.write {
            object.isBookmarked = false
            database.add(object, update: true)
        }
    }
}
