//
//  FavoritesUseCaseMock.swift
//  MovsTests
//
//  Created by Joao Lucas on 17/10/20.
//

import Foundation
import RealmSwift
@testable import Movs

class FavoritesUseCaseMock: FavoritesUseCase {
    
    override func removeFavoriteList(realm: Realm, item: FavoriteEntity, onSuccess: @escaping (() -> Void)) {
        onSuccess()
    }
    
}
