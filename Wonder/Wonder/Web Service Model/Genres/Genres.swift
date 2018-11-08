//
//  Wonder
//  Genres
//
//  Created by Marcelo
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

public class Genres: NSObject, NSCoding {

    var id = Int()
	var name = String()
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(dictionary: NSDictionary) {
        if let id = dictionary["genreId"] as? Int {
            self.id = id
        }
        if let name = dictionary["genreName"] as? String {
            self.name = name
        }
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "genreId")
        aCoder.encode(name, forKey: "genreName")
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "genreId")
        let name = aDecoder.decodeObject(forKey: "genreName") as! String
        self.init(id: id, name: name)
    }
    
    
}

