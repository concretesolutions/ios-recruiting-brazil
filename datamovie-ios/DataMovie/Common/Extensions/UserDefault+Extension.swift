//
//  UserDefault+Extension.swift
//  DataMovie
//
//  Created by Andre Souza on 09/10/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import Foundation

protocol KeyNamespaceable { }

extension KeyNamespaceable {
    func namespace<T: RawRepresentable>(_ key: T) -> String where T.RawValue == String {
        return namespace(key.rawValue)
    }
    
    private func namespace(_ key: String) -> String {
        return "\(Self.self).\(key)"
    }
}

// MARK: - Bool Defaults
protocol BoolUserDefaultable : KeyNamespaceable {
    associatedtype BoolDefaultKey : RawRepresentable
}

extension BoolUserDefaultable where BoolDefaultKey.RawValue == String {
    
    // Set
    func set(_ bool: Bool, forKey key: BoolDefaultKey) {
        let key = namespace(key)
        UserDefaults.standard.set(bool, forKey: key)
    }
    
    // Get
    func bool(forKey key: BoolDefaultKey) -> Bool {
        let key = namespace(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}


// MARK: - UserDefaults -

extension UserDefaults {
    static let setupConfiguration = SetupConfiguration()
    static let movieListFilters = MovieListFilters()
}
