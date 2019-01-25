//
//  UserDefaults+Extensions.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

extension UserDefaults {
    func customObject<T: Codable>(for key: String) -> T? {
        guard let data = self.data(forKey: key) else { return nil}
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func set<T: Codable>(_ customObject: T, for key: String) {
        guard let data = try? JSONEncoder().encode(customObject) else { return }
        self.set(data, forKey: key)
    }
}
