//
//  SettingsDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 08/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

protocol SettingsDataSource {
    func setYearFilter(_ year: Int)
    func setGenreFilter(_ genre: String)
    func getYearFilter() -> Int?
    func getGenreFilter() -> String?
}

class SettingsDataSourceImpl: SettingsDataSource {

    enum Keys {
        static let year = "year"
        static let genre = "genre"
    }

    func setYearFilter(_ year: Int) {
        UserDefaults.standard.set(year, forKey: Keys.year)
        UserDefaults.standard.synchronize()
    }

    func setGenreFilter(_ genre: String) {
        UserDefaults.standard.set(genre, forKey: Keys.genre)
        UserDefaults.standard.synchronize()
    }

    func getYearFilter() -> Int? {
        let year = UserDefaults.standard.integer(forKey: Keys.year)
        if year > 0 {
            return year
        }
        return nil
    }

    func getGenreFilter() -> String? {
        return UserDefaults.standard.string(forKey: Keys.genre)
    }
}
