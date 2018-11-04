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
    
    /**
     Return All favorited movies from a given type and Filter
     - parameter type: Type of the Media that you want to retrieve
     - parameter filter: The filter to b aplied on the data request
     - Returns: Array of MediaItems
     */
    func getFavorites(type:MediaType, filter:Filter)->Array<MediaItem>{
        
        var favorites:Array<MediaItem> = Array()
        
        var results:Results<MediaItemDao>
        
        if(filter.selectedYears.count > 0){
            results = realm.objects(MediaItemDao.self).filter("type = %@ AND year IN %@", type.rawValue, filter.selectedYears)
        }else{
            results = realm.objects(MediaItemDao.self).filter("type = %@", type.rawValue)
        }
        
        for recordedMedia in results{
            
            if(filter.selectedGenresIds.count > 0){//filter genders
                
                let savedGenres = recordedMedia.getGenres()
                
                print("passando nos cara")
                print(savedGenres)
                print(filter.selectedGenresIds)
                
                let outpus = savedGenres.filter { (intValue) -> Bool in
                    return filter.selectedGenresIds.contains(intValue)
                }
                
                if(outpus.count > 0){
                    if(type == .movie){
                        let movie = MovieMediaItem(record: recordedMedia)
                        favorites.append(movie)
                    }else{
                        let tvShow = TvShowMediaItem(record: recordedMedia)
                        favorites.append(tvShow)
                    }
                }
                
            }else{//Returs filter by year only
                if(type == .movie){
                    let movie = MovieMediaItem(record: recordedMedia)
                    favorites.append(movie)
                }else{
                    let tvShow = TvShowMediaItem(record: recordedMedia)
                    favorites.append(tvShow)
                }
            }
            
        }
        
        return favorites
        
    }
    
    
    /**
     Get the available movie or tv genres in the entire database, with this the user will not have to select a genre that he havent added to favorites yet.
     */
    func getAvailableGenres(type:MediaType)->Array<Int>{
        
        var genres:Array<Int> = Array()
        
        let results = realm.objects(MediaItemDao.self).filter("type = %@", type.rawValue)
        
        for media in results{
            
            for g in media.genres{
                if(!genres.contains(g.id)){
                    genres.append(g.id)
                }
            }
            
        }
        
        return genres
        
    }
    
    
    /**
     Get the available movie or tv years in the entire database, with this the user will not have to select a year that he havent added to favorites yet.
     */
    func getAvailableYears()->Array<String>{
        
        var years:Array<String> = Array()
        
        let results = realm.objects(MediaItemDao.self)
        
        for media in results{
            
            let dateElements = media.releaseDate.components(separatedBy: "-")
            
            if let year = dateElements.first{
                if(!years.contains(year)){
                    years.append(year)
                }
            }
            
        }
        
        return years
        
    }
    
    
}
