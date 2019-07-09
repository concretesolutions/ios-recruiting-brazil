//
//  UserDefaultsFavoriteProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

class UserDefaultsFavoriteProvider {
    let defaults = UserDefaults.standard
    let identifier = "favorites_ids"
}

extension UserDefaultsFavoriteProvider: FavoritesProvider {
    func addNew(withId id: Int) {
        guard let value = self.defaults.value(forKey: self.identifier),
            var allIds = value as? [Int] else {
                let ids = [id]
                self.defaults.setValue(ids, forKey: self.identifier)
                return
        }
        
        allIds.append(id)
        self.defaults.setValue(allIds, forKey: self.identifier)
    }
    
    func delete(withId id: Int) {
        guard let value = self.defaults.value(forKey: self.identifier),
            var allIds = value as? [Int] else {
                return
        }
        
        allIds = allIds.filter { (element) -> Bool in
            return element != id
        }
        
        self.defaults.setValue(allIds, forKey: self.identifier)

        
    }
    
    func getAllIds() -> [Int] {
        guard let value = self.defaults.value(forKey: self.identifier),
                let allIds = value as? [Int] else {
            return []
        }
    
        return allIds
    }
    
}
