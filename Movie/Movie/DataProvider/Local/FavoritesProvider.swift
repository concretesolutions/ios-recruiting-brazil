//
//  FavoritesProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation


protocol FavoritesProvider {
    func addNew(withId id: Int)
    func delete(withId id: Int)
    func getAllIds() -> [Int]
    
}
