//
//  Genre.swift
//  TheMovieDBConcrete
//
//  Created by eduardo soares neto on 21/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit

class Genre: NSObject, NSCoding {

    var genreId: Int
    var name: String
    
    
    required public init?(coder aDecoder: NSCoder) {
        if let genreId = aDecoder.decodeObject(forKey: "genreId") as? Int {
            self.genreId = genreId
        } else {
            self.genreId = 0
        }
        if let name = aDecoder.decodeObject(forKey: "name") as? String {
            self.name = name
        } else {
            self.name = ""
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(genreId, forKey: "genreId")
        aCoder.encode(name, forKey: "name")
    }
    
    override init() {
        genreId = 0
        name = ""
    }
    
    init(genreId: Int, name: String) {
        self.genreId = genreId
        self.name = name
    }
    init(genreId: Int) {
        self.genreId = genreId
        self.name = ""
    }
}
