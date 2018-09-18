//
//  DBManager.swift
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import RealmSwift
class DBManager {
    private var database: Realm
    static let sharedInstance = DBManager()
    private init() {
        database = try! Realm()
    }
    func getDataFromDB() -> Results<MovieObject> {
        let results: Results<MovieObject> = database.objects(MovieObject.self)
        return results
    }
    
    func addData(object: MovieObject)   {
        try! database.write {
            database.add(object, update: true)
        }
    }
    
    func deleteAllFromDatabase()  {
        try! database.write {
            database.deleteAll()
        }
    }
    
    func deleteFromDb(object: MovieObject)   {
        try! database.write {
            database.delete(object)
        }
    }
    
    func createObject(model: MovieData)->MovieObject {
        let object = MovieObject()
        object.id = model.id
        object.originalTitle = model.originalTitle
        object.posterPath = model.posterPath
        object.overview = model.overview
        object.releaseDate = model.releaseData
        model.genres.forEach {
            object.genres.append(createGenreObject(model: $0))
        }
        return object
    }
    
    func createGenreObject(model: GenreData)->GenreObject {
        let object = GenreObject()
        object.id = model.id
        object.name = model.name
        return object
    }
    
    func moveIsFavored(movieId: Int) -> Bool {
        let entries = database.objects(MovieObject.self).filter("id = %d", movieId)
        return entries.count > 0
    }
    
    func deleteMovie(movieId: Int) {
        let entries = database.objects(MovieObject.self).filter("id = %d", movieId)
        if entries.count > 0 {
            deleteFromDb(object: entries.first!)
        }
    }
}
