//
//  DatabaseWorker.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import Realm
import RealmSwift

class DatabaseWorker {
    
    static let shared = DatabaseWorker()
    
    let realm:Realm
    
    private init() {
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                
                print("Migration is necessary...")
                print("Migrating realm database to the new version... 🎲🎲🎲")
                
        },
            shouldCompactOnLaunch: { totalBytes, usedBytes in//Compact database on lauch to avoid known issue with realm database size
                
                return (Double(usedBytes) / Double(totalBytes)) < 0.5
                
        })
        
        realm = try! Realm(configuration: config)
        
    }
    
    /**
     Check if the MediaItem is favorited
     */
    func isFavorited(media:MediaItem)->Bool{
        
        let result = realm.objects(MediaItemDao.self).filter("id = %@ AND type = %@", media.id, media.mediaType.rawValue)
        
        if(result.count > 0){
            return true
        }else{
            return false
        }
        
    }
    
    /**
     Add MediaItem to Reaml
     */
    func addMediaToFavorites(media:MediaItem){
        
        let newFavorite = MediaItemDao(mediaItem: media)
        
        try! realm.write {
            realm.add(newFavorite)
        }
        
    }
    
    /**
     Delete MediaItem from Reaml
     */
    func removeMediaFromFavorites(media:MediaItem){
        
        let result = realm.objects(MediaItemDao.self).filter("id = %@ AND type = %@", media.id, media.mediaType.rawValue)
        
        if(result.count > 0){
            
            try! realm.write {
                realm.delete(result)
            }
            
        }
        
    }
    
    /**
     Return All favorited movies from a given type
     - parameter type: Type of the Media that you want to retrieve
     - Returns: Array of MediaItems
     */
    func getFavorites(type:MediaType)->Array<MediaItem>{
        
        var favorites:Array<MediaItem> = Array()
        
        let results = realm.objects(MediaItemDao.self).filter("type = %@", type.rawValue)
        
        for recordedMedia in results{
            
            if(type == .movie){
                
                let movie = MovieMediaItem(record: recordedMedia)
                favorites.append(movie)
                
            }else{
                
                let tvShow = TvShowMediaItem(record: recordedMedia)
                favorites.append(tvShow)
                
            }
            
        }
        
        return favorites
        
    }
    
    
}
