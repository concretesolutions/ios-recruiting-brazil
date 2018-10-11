//
//  UserDefaults Services.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 10/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import Foundation

struct Keys {
    
    struct favoriteMovies {
        static let isThereAnyFavoriteMovie = "isThereAnyFavoriteMovie"
        static let favoriteMoviesArray = "favoriteMoviesArray"
        static let favoriteMoviesIndexArray = "favoriteMoviesIndexArray"
        static let movieidList = "movieidList"
    }
    
    private init(){}
    
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init(){}
    
    var isThereAnyFavoriteMovie: Bool{
        
        get{
            return UserDefaults.standard.bool(forKey: Keys.favoriteMovies.isThereAnyFavoriteMovie)
        }
        
        set{
            return UserDefaults.standard.set(newValue,forKey: Keys.favoriteMovies.isThereAnyFavoriteMovie)
        }
    }
    
    var favoriteMoviesArray: Array<FavoriteMovie>{
        
        get{
            let data = UserDefaults.standard.object(forKey: Keys.favoriteMovies.favoriteMoviesArray) as! Data
            return NSKeyedUnarchiver.unarchiveObject(with: data) as! [FavoriteMovie]
        }
        
        set{
            let encodedArray: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            return UserDefaults.standard.set(encodedArray,forKey:Keys.favoriteMovies.favoriteMoviesArray)
        }
        
    }
    
    var favoriteMoviesIndexArray: Array<Int>{
        
        get{
           return UserDefaults.standard.array(forKey: Keys.favoriteMovies.favoriteMoviesIndexArray) as! Array<Int>
        }
        
        set{
            return UserDefaults.standard.set(newValue, forKey: Keys.favoriteMovies.favoriteMoviesIndexArray)
        }
        
    }
    
    var movieIdList: Array<String>{
        
        get{
            return UserDefaults.standard.array(forKey: Keys.favoriteMovies.movieidList) as! Array<String>
        }
        
        set{
            return UserDefaults.standard.set(newValue, forKey: Keys.favoriteMovies.movieidList)
        }
        
    }
    
}
