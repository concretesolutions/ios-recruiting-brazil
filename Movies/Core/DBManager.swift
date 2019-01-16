//
//  DBManager.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/11/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation
import FMDB
import UIKit

class DBManager {
    static let shared = DBManager()
    let latestDBversion: Int32 = 1
    
    var dbQueue: FMDatabaseQueue?
    let infoParser = Parser.shared
    let defaultFileManager = FileManager.default
    
    open func startDB() {
        if(dbQueue == nil) {
            let fileURL = try! defaultFileManager.url(for: .documentDirectory,
                                                      in: .userDomainMask,
                                                      appropriateFor: nil,
                                                      create: false).appendingPathComponent("moviesDatabase.sqlite")
            
            dbQueue = FMDatabaseQueue(path: fileURL.path)
            
        }
        verifyDBVersion()
    }
    
    open func verifyDBVersion() {
        self.dbQueue?.inDatabase { db in
            do {
                let versionTableExists: FMResultSet = try db.executeQuery("SELECT version FROM dbVersion", values: nil)
                if (versionTableExists.next()){
                    let dbVersion: Int32 = versionTableExists .int(forColumn: "version")
                    if(dbVersion >= latestDBversion){
                        print("DB Already in latest Version")
                    } else {
                        migrateDB(fromVersion: dbVersion)
                    }
                    
                }
            } catch {
                print("No dbVersionTable. Error: \(error.localizedDescription)")
                createDBInLatestVersion(db: db)
            }
            
        }
    }
    
    open func createDBInLatestVersion(db: FMDatabase) {
        do {
            try db.executeUpdate("CREATE TABLE IF NOT EXISTS Favorites(id TEXT PRIMARY KEY NOT NULL, title TEXT, overview TEXT, popularity REAL, thumbnailPath TEXT, isThumbnailLoaded BOOLEAN, releaseDateString TEXT, genresID TEXT, genresString TEXT )", values: nil)
            try db.executeUpdate("CREATE TABLE IF NOT EXISTS dbVersion(id INT PRYMARY KEY NOT NULL, version INT)", values: nil)
            updateDBVersionInTable(db: db)
            print("DB created in version: \(latestDBversion)")
        } catch {
            print("Error creating tables: \(error.localizedDescription)")
        }
    }
    
    open func migrateDB(fromVersion version:Int32){
    }
    
    open func updateDBVersionInTable(db: FMDatabase) {
        do {
            try db.executeUpdate("INSERT OR REPLACE INTO dbVersion (id, version) VALUES ('1',?)", values: [latestDBversion])
        } catch {
            print("Error updating database version in dbVersion table: \(error.localizedDescription)")
        }
    }
    
    open func getFavorites(completion: @escaping (_ favorites: [MovieModel]) -> Void){
        var favoriteMovies = [MovieModel]()
        self.dbQueue?.inDatabase{ db in
            do {
                let haveFavoritesSaved: FMResultSet =  try db.executeQuery("SELECT * FROM Favorites", values: nil)
                while(haveFavoritesSaved.next()){
                    let retrievedId = haveFavoritesSaved.int(forColumn: "id")
                    let title = haveFavoritesSaved.string(forColumn: "title")
                    let overview = haveFavoritesSaved.string(forColumn: "overview")
                    let popularity = haveFavoritesSaved.double(forColumn: "popularity")
                    let thumbPath = haveFavoritesSaved.string(forColumn: "thumbnailPath")
                    let isThumbnailLoaded = haveFavoritesSaved.bool(forColumn: "isThumbnailLoaded")
                    let releaseDateString = haveFavoritesSaved.string(forColumn: "releaseDateString")
                    let genresID = haveFavoritesSaved.string(forColumn: "genresID")
                    let genresString = haveFavoritesSaved.string(forColumn: "genresString")
                    
                    let parsedGenresID = infoParser.parseGenresID(fromDatabase: genresID!)
                    let parsedGenres = genresString?.components(separatedBy: ",")
                    
                    //Retrieving Image Saved
                    var thumbnail = UIImage(named: "placeHolder")
                    let imagePath = try defaultFileManager.url(for: .documentDirectory,
                                                               in: .userDomainMask,
                                                               appropriateFor: nil,
                                                               create: false).appendingPathComponent("/images/\(retrievedId).jpg")
                    if (defaultFileManager.fileExists(atPath: imagePath.path)) {
                        thumbnail = UIImage(contentsOfFile: imagePath.path)
                    }
                    let newMovie = MovieModel(fromDatabase: Int(retrievedId),
                                              newTitle: title!,
                                              newOverview: overview!,
                                              newPopularity: popularity,
                                              newThumbPath: thumbPath!,
                                              newIsThumbnailLoaded: isThumbnailLoaded,
                                              newReleaseDateString: releaseDateString!,
                                              newGenresId: parsedGenresID,
                                              newGenresString: parsedGenres!,
                                              newThumbnail: thumbnail!)
                    favoriteMovies.append(newMovie)
                }
                completion(favoriteMovies)
            } catch {
                
            }
        }
    }
    
    open func addToFavorites(movie: MovieModel) {
        self.dbQueue?.inDatabase{ db in
            do {
                let genresIDString = NSMutableString()
                movie.genresIDArray.forEach{ genreID in
                    genresIDString.append("\(genreID), ")
                }
                
                let allGenresString = NSMutableString()
                movie.genresStringSet.forEach{ genre in
                    allGenresString.append("\(genre),")
                }
                
                try db.executeUpdate("INSERT INTO Favorites(id, title, overview, popularity, thumbnailPath, isThumbnailLoaded, releaseDateString, genresID, genresString) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", values: [movie.id, movie.title, movie.overview, movie.popularity, movie.thumbnailPath, movie.isThumbnailLoaded, movie.releaseDateString, genresIDString, allGenresString])
                
                createImageDirectory()
                
                let imagePath = try defaultFileManager.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false).appendingPathComponent("/images/\(movie.id).jpg")
                
                let imageData = movie.thumbnail.jpegData(compressionQuality: 0.5)
                defaultFileManager.createFile(atPath: imagePath.path, contents: imageData, attributes: nil)
                
                print("\(movie.title) added to favorites")
            } catch {
                print("Error while saving movie: \(error.localizedDescription)")
            }
        }
    }
    
    open func removeFromFavorites(movie: MovieModel) {
        self.dbQueue?.inDatabase{db in
            do{
                try db.executeUpdate("DELETE FROM Favorites WHERE id = ?", values: [movie.id])
                let imagePath = try defaultFileManager.url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: false).appendingPathComponent("/images/\(movie.id).jpg")
                try defaultFileManager.removeItem(at: imagePath)
                print("Succesfully removed \(movie.title) from favorites")
            }catch{
                print("Error removing \(movie.title) from favorites: \(error.localizedDescription)")
            }
        }
    }
    
    func createImageDirectory(){
        do {
            let imagePath = try defaultFileManager.url(for: .documentDirectory,
                                                       in: .userDomainMask,
                                                       appropriateFor: nil,
                                                       create: false).appendingPathComponent("/images/")
            if(!defaultFileManager.fileExists(atPath: imagePath.path)){
                try defaultFileManager.createDirectory(atPath: imagePath.path, withIntermediateDirectories: true, attributes: nil)
            } else {
                print("Images Directory Already Exists")
            }
        } catch {
            
        }
    }
    
    open func getFavoritesQuantity() -> Int{
        var quantity = Int()
        self.dbQueue?.inDatabase { db in
            do {
                let favoritesCounter = try db.executeQuery("SELECT COUNT(*) FROM Favorites", values: nil)
                if (favoritesCounter.next()){
                    quantity = Int(favoritesCounter.int(forColumn: "COUNT(*)"))
                }
            } catch {
                print("Error getting quantity of Favorites:\(error.localizedDescription)")
            }
        }
        return quantity
    }
    
    open func verifyIfIsFavorite(movie: MovieModel) -> Bool{
        var isFavorite: Bool = false
        self.dbQueue?.inDatabase { db in
            do{
                let verifyFavorite = try db.executeQuery("SELECT * FROM Favorites WHERE id = ?", values: [movie.id])
                if(verifyFavorite.next()){
                    isFavorite = true
                }
            } catch {
                
            }
        }
        return isFavorite
    }
}
