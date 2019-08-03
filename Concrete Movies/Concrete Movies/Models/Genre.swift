//
//  Genre.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 02/08/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import RealmSwift

class Genre: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
}
