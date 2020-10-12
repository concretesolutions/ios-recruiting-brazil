//
//  FavoriteEntity.swift
//  Movs
//
//  Created by Joao Lucas on 10/10/20.
//

import Foundation
import RealmSwift

class FavoriteEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var photo: String = ""
    @objc dynamic var genre: String = ""
    @objc dynamic var year: String = ""
    
    override class func primaryKey() -> String {
        return "id"
    }
}
