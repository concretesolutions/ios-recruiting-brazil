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
}
