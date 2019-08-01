//
//  Movie.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import RealmSwift

class Movie: Object {
    @objc dynamic var name = ""
    @objc dynamic var image: Data? = nil
}
