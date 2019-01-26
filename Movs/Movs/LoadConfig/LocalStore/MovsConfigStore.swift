//
//  MovsConfigStore.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

protocol ConfigStore {
    func store(config: MovsConfig)
    func config() -> MovsConfig?
}

class MovsConfigStore: ConfigStore {
    let key: String = "MovsConfig"
    let defaults = UserDefaults.standard

    func store(config: MovsConfig) {
        defaults.set(config, for: key)
    }

    func config() -> MovsConfig? {
        return defaults.customObject(for: key)
    }
}
