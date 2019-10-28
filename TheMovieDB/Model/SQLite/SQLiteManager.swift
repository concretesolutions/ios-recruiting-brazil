//
//  SQLiteManager.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import SQLite3
import Foundation

class SQLiteManager {
    
    private let SQLITE_STATIC = unsafeBitCast(0, to: sqlite3_destructor_type.self)
    private let SQLITE_TRANSIENT = unsafeBitCast(-1, to: sqlite3_destructor_type.self)
    
    private let dbName = "themoviedb.sqlite"
    
    private let tbMovie = "tb_movie"
    private let movieID = "movie_id"
    private let movieName = "movie_name"
    private let movieDate = "movie_date"
    private let movieDesc = "movie_desc"
    private let movieImage = "movie_image"
    
    init() {
        openDatabase()
        createTable()
    }
    
    private var db: OpaquePointer!
    
    private func openDatabase() {
        let fileURL = try! FileManager.default.url(for: .documentDirectory,
                                                   in: .userDomainMask,
                                                   appropriateFor: nil,
                                                   create: false)
            .appendingPathComponent(dbName)
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Unable to open database.")
        }
    }
    
    // MARK: - CreateTable
    private func createTable() {
        var createTableStatement: OpaquePointer? = nil
        
        let createTbMovie = "CREATE TABLE IF NOT EXISTS \(tbMovie) (" +
            "\(movieID) INTEGER primary key, " +
            "\(movieName) TEXT NOT NULL, " +
            "\(movieDate) TEXT NOT NULL, " +
            "\(movieDesc) TEXT NOT NULL, " +
        "\(movieImage) TEXT NOT NULL)"
        
        if sqlite3_prepare_v2(db, createTbMovie, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) != SQLITE_DONE {
                print("Table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // MARK: - Insert
    func insertFavoritedMovie(_ movie: MovieResponse) {
        var insertStatement: OpaquePointer? = nil
        
        let insertStatementString = "INSERT INTO \(tbMovie) " +
            "(\(movieID), \(movieName), \(movieDate), " +
            "\(movieDesc), \(movieImage)) " +
        "VALUES (?, ?, ?, ?, ?);"
        print(insertStatementString)
        
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            let id = Int32(movie.id ?? 0)
            sqlite3_bind_int(insertStatement, 1, id)
            
            let title = NSString(string: movie.title ?? "")
            sqlite3_bind_text(insertStatement, 2, title.utf8String, -1, nil)
            
            let releaseDate = NSString(string: movie.releaseDate ?? "")
            sqlite3_bind_text(insertStatement, 3, releaseDate.utf8String, -1, nil)
            
            let overview = NSString(string: movie.overview ?? "")
            sqlite3_bind_text(insertStatement, 4, overview.utf8String, -1, nil)
            
            let posterPath = NSString(string: movie.posterPath ?? "")
            sqlite3_bind_text(insertStatement, 5, posterPath.utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) != SQLITE_DONE {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // MARK: - Select
    func selectFavoritedMovies() -> [MovieResponse] {
        var queryStatement: OpaquePointer? = nil
        var listMovies = [MovieResponse]()
        var movie: MovieResponse!
        let queryStatementString = "SELECT * FROM \(tbMovie)"
        print(queryStatementString)
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                movie = MovieResponse()
                
                let id = sqlite3_column_int(queryStatement, 0)
                movie.id = Int(id)
                
                let title = sqlite3_column_text(queryStatement, 1)
                movie.title = String(cString: title!)
                
                let releaseDate = sqlite3_column_text(queryStatement, 2)
                movie.releaseDate = String(cString: releaseDate!)
                
                let overview = sqlite3_column_text(queryStatement, 3)
                movie.overview = String(cString: overview!)
                
                let posterPath = sqlite3_column_text(queryStatement, 4)
                movie.posterPath = String(cString: posterPath!)
                
                listMovies.append(movie)
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return listMovies
    }
    
    // MARK: - Delete
    func deleteFavoritedMovie(_ movie: MovieResponse) {
        let deleteString = "DELETE FROM \(tbMovie) WHERE \(movieID) = '\(movie.id ?? 0)'"
        print(deleteString)
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteString, -1, &deleteStatement, nil) == SQLITE_OK {
            if sqlite3_step(deleteStatement) != SQLITE_DONE {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
}
