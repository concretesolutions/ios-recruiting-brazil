//
//  SalvedDatas.swift
//  Mov
//
//  Created by Victor Leal on 20/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import Foundation

class SalvedDatas{
    
    var userDefaults = UserDefaults.standard
    static let shared: SalvedDatas = SalvedDatas()
    
    var favoriteMovies: [String]{
        get{
            return userDefaults.array(forKey: "favoritesMovie") as! [String]
        }
        set{
            userDefaults.set(newValue, forKey: "favoritesMovie")
        }
    }
    
    var dictionaryFavoriteMovies: [String : Bool]{
        get{
            return userDefaults.dictionary(forKey: "favoritesMovie2") as! [String : Bool]
        }
        set{
            userDefaults.set(newValue, forKey: "favoritesMovie2")
        }
    }
    
    init() {
        // userDefaults.set(nil, forKey: "favoritesMovie")
        
        if userDefaults.array(forKey: "favoritesMovie")  == nil{
            userDefaults.set([], forKey: "favoritesMovie")
        }
        
        if userDefaults.dictionary(forKey: "favoritesMovie2")  == nil{
            userDefaults.set([:], forKey: "favoritesMovie2")
        }
    }
    
    
    
}
