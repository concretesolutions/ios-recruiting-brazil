//
//  Wonder
//  GenresList
//
//  Created by Marcelo
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation


class GenresList{
    
    var genres = [Genres]()
    
    init() {
        self.genres = [Genres]()
    }

    
    init(dictionary: NSDictionary) {
        
        let array = dictionary["genres"] as! NSArray
        for item in array {
            let itemDic = item as! NSDictionary
            let id = itemDic["id"] as! Int
            let name = itemDic["name"] as! String
            
            let genre : Genres = Genres(id: id, name: name)
            self.genres.append(genre)
        }
    }
    
    
}
