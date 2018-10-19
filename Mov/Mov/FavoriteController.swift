//
//  FavoriteController.swift
//  Mov
//
//  Created by Allan on 15/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation
import SwiftyJSON

final class FavoriteController {
    static let shared = FavoriteController()
    private(set) var favorites = [Movie]()
    
    init() {
        guard let favoritesJSON = UserDefaults.standard.array(forKey: Constants.Keys.MyFavorites) else { return }
        self.favorites = favoritesJSON.compactMap({Movie(with: JSON($0))})
    }
    
    func add(favorite: Movie, postNotification: Bool = false){
        self.favorites.append(favorite)
        let favoriteJSON = self.favorites.compactMap({$0.jsonValue})
        UserDefaults.standard.set(favoriteJSON, forKey: Constants.Keys.MyFavorites)
        UserDefaults.standard.synchronize()
        
        if postNotification{
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "favoriteAdded")))
        }
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "favoritesChanged")))
    }
    
    func remove(favorite: Movie, postNotification: Bool = false){
        guard let index = self.favorites.index(of: favorite) else { return }
        self.favorites.remove(at: index)
        let favoriteJSON = self.favorites.compactMap({$0.jsonValue})
        UserDefaults.standard.set(favoriteJSON, forKey: Constants.Keys.MyFavorites)
        UserDefaults.standard.synchronize()
        if postNotification{
            NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "favoriteRemoved")))
        }
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "favoritesChanged")))
    }
    
    func remove(at index: Int){
        self.favorites.remove(at: index)
        let favoriteJSON = self.favorites.compactMap({$0.jsonValue})
        UserDefaults.standard.set(favoriteJSON, forKey: Constants.Keys.MyFavorites)
        UserDefaults.standard.synchronize()
        NotificationCenter.default.post(Notification(name: Notification.Name(rawValue: "favoriteRemoved")))
    }
}
