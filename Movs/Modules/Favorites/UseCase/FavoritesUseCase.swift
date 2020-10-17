//
//  FavoritesUseCase.swift
//  Movs
//
//  Created by Joao Lucas on 16/10/20.
//

import Foundation
import RealmSwift

class FavoritesUseCase {

    func removeFavoriteList(realm: Realm, item: FavoriteEntity,
                            onSuccess: @escaping (() -> Void)) {
        realm.beginWrite()
        realm.delete(item)
        try! realm.commitWrite()
        
        onSuccess()
    }
}
