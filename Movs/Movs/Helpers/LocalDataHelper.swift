//
//  LocalDataHelper.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import RealmSwift

class LocalDataHelper {
    static let shared = LocalDataHelper()
    
    func saveGenres(genres: [GenreModel]){
        if let realm = try? Realm(){
            try? realm.write {
                realm.add(genres, update: true)
            }
        }
    }
    
    func getGenres() -> [GenreModel]{
        if let realm = try? Realm(){
            let array = Array(realm.objects(GenreModel.self))
            return array
        }else{
            return []
        }
    }
    
    func saveMovie(movie: MovieModel, block:(_ movie: MovieModel)->Void){
        if let realm = try? Realm(){
            try? realm.write {
                realm.add(movie, update: true)
                block(movie)
            }
        }
    }
    
    func getListOfSaveMovies(_ block: (_ movies:[MovieModel])->Void){
        var array: [MovieModel] = []
        if let realm = try? Realm(){
            let arrayRealm = realm.objects(MovieModel.self)
            array = Array(arrayRealm)
            block(array)
        }else{
            block([])
        }
    }
}
