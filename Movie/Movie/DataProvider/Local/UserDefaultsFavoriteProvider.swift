//
//  UserDefaultsFavoriteProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

class UserDefaultsFavoriteProvider {
    private let defaults = UserDefaults.standard
    private let identifier = "favorites_ids"
}

extension UserDefaultsFavoriteProvider: FavoritesProvider {
    func addNew(withId id: Int) -> [Int] {
        guard let value = self.defaults.value(forKey: self.identifier),
            var allIds = value as? [Int] else {
                let ids = [id]
                self.defaults.setValue(ids, forKey: self.identifier)
                return ids
        }
        if allIds.contains(id) {
            return allIds
        } else {
            allIds.append(id)
            self.defaults.setValue(allIds, forKey: self.identifier)
            return allIds
        }
        
    }
    
    func delete(withId id: Int) -> [Int] {
        guard let value = self.defaults.value(forKey: self.identifier),
            var allIds = value as? [Int] else {
                return []
        }
        
        allIds = allIds.filter { (element) -> Bool in
            return element != id
        }
        
        self.defaults.setValue(allIds, forKey: self.identifier)
        return allIds
        
    }
    
    func getAllIds() -> [Int] {
        guard let value = self.defaults.value(forKey: self.identifier),
                let allIds = value as? [Int] else {
            return []
        }
    
        return allIds
    }
    
    func isFavorite(_ id: Int) -> Bool {
        guard let value = self.defaults.value(forKey: self.identifier),
            let allIds = value as? [Int] else {
                return false
        }
        
        return allIds.contains(id)
    }
    
}
