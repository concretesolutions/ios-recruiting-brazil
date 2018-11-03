//
//  MediaItemDao.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Realm
import RealmSwift

enum MediaType:Int{
    case movie = 1
    case tv = 2
}

/**
 Realm Media item Model
 */
class MediaItemDao:Object{
    
    @objc dynamic var id:Int = 0
    @objc dynamic var evaluation:Float = 0
    @objc dynamic var title:String = ""
    @objc dynamic var poster:String? = nil
    @objc dynamic var overview:String = ""
    @objc dynamic var releaseDate:String = ""
    var genres = RealmSwift.List<GenreDao>()
    @objc dynamic var type:Int = 0
    
    convenience init(mediaItem:MediaItem){
        
        self.init()
        
        id = mediaItem.id
        evaluation = mediaItem.evaluation
        title = mediaItem.title
        poster = mediaItem.poster
        overview = mediaItem.overview
        releaseDate = mediaItem.releaseDate
        
        type = mediaItem.mediaType.rawValue
        
        setGenres(mediaGenres: mediaItem.genres)
        
    }
    
    func setGenres(mediaGenres:Array<Int>){
        for genre in mediaGenres{
            let newRealmGenre = GenreDao()
            newRealmGenre.id = genre
            genres.append(newRealmGenre)
        }
    }
    func getGenres()->Array<Int>{
        var recordedGenres:Array<Int> = Array()
        
        for genre in genres{
            let recordedGenre = genre.id
            recordedGenres.append(recordedGenre)
        }
        
        return recordedGenres
    }
    
}
