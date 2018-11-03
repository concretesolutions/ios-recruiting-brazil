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
    
    func isFavorited(media:MediaItem)->Bool{
        
        let result = realm.objects(MediaItemDao.self).filter("id = %@ AND type = %@", media.id, media.mediaType.rawValue)
        
        if(result.count > 0){
            return true
        }else{
            return false
        }
        
    }
    
    func addMediaToFavorites(media:MediaItem){
        
        let newFavorite = MediaItemDao(mediaItem: media)
        
        try! realm.write {
            realm.add(newFavorite)
        }
        
    }
    
    func removeMediaFromFavorites(media:MediaItem){
        
        let result = realm.objects(MediaItemDao.self).filter("id = %@ AND type = %@", media.id, media.mediaType.rawValue)
        
        if(result.count > 0){
            
            try! realm.write {
                realm.delete(result)
            }
            
        }
        
    }
    
    
}
