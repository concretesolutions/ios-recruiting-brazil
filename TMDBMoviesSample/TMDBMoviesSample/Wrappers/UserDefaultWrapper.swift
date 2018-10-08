//
//  UserDefaultWrapper.swift
//  ToDoListSample
//
//  Created by Breno Rage Aboud on 29/09/18.
//  Copyright © 2018 Breno Rage Aboud. All rights reserved.
//

import Foundation

class UserDefaultWrapper {
    let tmdbFavsKey = "TMDBFavsKey"
    let configModelKey = "ConfigModelKey"
    let genresIdsKey = "GenresIdsKey"
    
    private let defaults = UserDefaults.standard
    
    func get<T>(with key: String) -> T? {
        let data = defaults.object(forKey: key)
        if let unwrappedData = data as? T {
            return unwrappedData
        } else {
            return nil
        }
    }
    
    func save<T>(object: T, with key: String) {
        defaults.set(object, forKey: key)
    }
    
    func appendItem<T>(_ data: T, with key: String) {
        guard let result: [T] = get(with: key) else {
            defaults.set([data], forKey: key)
            return
        }
        
        var recoveryArray = result
        recoveryArray.append(data)
        defaults.set(recoveryArray, forKey: key)
    }
    
    func deleteItem<T>(in index: Int, with key: String) -> [T]? {
        guard let result: [T] = get(with: key) else { return nil }
        var recoveryArray = result
        recoveryArray.remove(at: index)
        defaults.set(recoveryArray, forKey: key)
        return recoveryArray
    }
}
