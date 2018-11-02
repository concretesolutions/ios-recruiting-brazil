//
//  FilterProvider.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import Foundation
import RealmSwift


class FilterProvider {
    let realm: Realm!
    
    init() {
        self.realm = try! Realm()
    }
    
    func load() -> Filter? {
        return self.realm.objects(Filter.self).first
    }
    
    func save(filter: Filter?) {
        guard let filter = filter else {
            return
        }
        
        try! self.realm.write {
            self.realm.add(filter, update: true)
        }
    }
    
    func add(genre: Genre, in filter: Filter) {
        try! self.realm.write {
            filter.genres.append(genre)
        }
    }
    
    func add(year: Int, in filter: Filter) {
        try! self.realm.write {
            filter.years.append(year)
        }
    }
    
    func delete(year: Int, in filter: Filter) {
        try! self.realm.write {
            if let index = filter.years.index(of: year) {
                filter.years.remove(at: index)
            }
        }
    }
    
    func delete(genre: Genre, in filter: Filter) {
        try! self.realm.write {
            if let index = filter.genres.index(of: genre) {
                filter.genres.remove(at: index)
            }
        }
    }

    func clear(filter: Filter) {
        try! self.realm.write {
             filter.genres.removeAll()
            filter.years.removeAll()
        }
    }
    
}
