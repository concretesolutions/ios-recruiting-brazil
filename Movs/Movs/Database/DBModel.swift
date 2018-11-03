//
//  DBModel.swift
//  Movs
//
//  Created by Gabriel Reynoso on 03/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Realm
import RealmSwift

final class FavoriteMovie: Object {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var title:String = ""
    @objc dynamic var posterPath:String = ""
    @objc dynamic var releaseDate:String = ""
    @objc dynamic var overview:String = ""
    
    let genres = List<LocalGenre>()
    
    var actualGenres:[Genre] {
        return self.genres.map { $0.genre }
    }
    
    var isCompletlySaved:Bool {
        return !(self.releaseDate.isEmpty || self.overview.isEmpty)
    }
    
    var movie:Movie {
        return Movie(id: self.id,
                     title: self.title,
                     posterPath: self.posterPath)
    }
    
    var movieDetail:MovieDetail {
         return MovieDetail(id: self.id,
                            title: self.title,
                            posterPath: self.posterPath,
                            releaseDate: self.releaseDate,
                            genres: self.actualGenres,
                            overview: self.overview)
    }
    
    init(movie:Movie) {
        super.init()
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
    }
    
    init(movie:MovieDetail) {
        super.init()
        self.id = movie.id
        self.title = movie.title
        self.posterPath = movie.posterPath
        self.releaseDate = movie.releaseDate
        self.overview = movie.overview
        self.genres.append(objectsIn: movie.genres.map { LocalGenre(genre: $0) } )
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

final class LocalGenre: Object {
    
    @objc dynamic var id:Int = 0
    @objc dynamic var name:String = ""
    
    var genre:Genre {
        return Genre(id: self.id, name: self.name)
    }
    
    init(genre:Genre) {
        self.id = genre.id
        self.name = genre.name
        super.init()
    }
    
    required init() {
        super.init()
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
