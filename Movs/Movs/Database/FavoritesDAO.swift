//
//  FavoritesDAO.swift
//  Movs
//
//  Created by Gabriel Reynoso on 03/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import RealmSwift

final class FavoriesDAO {
    
    let realm:Realm
    
    init() throws {
        self.realm = try Realm()
    }
    
    func add(favoriteMovie:Movie) throws {
        try self.realm.write {
            let new = FavoriteMovie(movie: favoriteMovie)
            self.realm.add(new, update: self.contains(movie: favoriteMovie))
        }
    }
    
    func add(favoriteMovie:MovieDetail) throws {
        try self.realm.write {
            let new = FavoriteMovie(movie: favoriteMovie)
            self.realm.add(new, update: self.contains(movie: favoriteMovie))
        }
    }
    
    func remove(favoriteMovie:Movie) throws {
        guard let obj = self.realm.object(ofType: FavoriteMovie.self, forPrimaryKey: favoriteMovie.id) else { return }
        try self.realm.write {
            self.realm.delete(obj)
        }
    }
    
    func remove(favoriteMovie:MovieDetail) throws {
        guard let obj = self.realm.object(ofType: FavoriteMovie.self, forPrimaryKey: favoriteMovie.id) else { return }
        try self.realm.write {
            self.realm.delete(obj)
        }
    }
    
    func fetchAll() -> [Movie] {
        let objects = self.realm.objects(FavoriteMovie.self)
        return objects.map { $0.movie }
    }
    
    func fetchAll() -> [MovieDetail] {
        let objects = self.realm.objects(FavoriteMovie.self)
        return objects.map { $0.movieDetail }
    }
    
    func contains(movie:Movie) -> Bool {
        return self.realm.object(ofType: FavoriteMovie.self, forPrimaryKey: movie.id) != nil
    }
    
    func contains(movie:MovieDetail) -> Bool {
        return self.realm.object(ofType: FavoriteMovie.self, forPrimaryKey: movie.id) != nil
    }
}
