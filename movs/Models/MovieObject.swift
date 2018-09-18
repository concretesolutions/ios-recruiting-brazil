//
//  MovieObject
//  movs
//
//  Created by Renan Oliveira on 17/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import RealmSwift

class MovieObject: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var originalTitle: String = ""
    @objc dynamic var posterPath: String = ""
    var genres = List<GenreObject>()
    @objc dynamic var overview: String = ""
    @objc dynamic var releaseDate: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
