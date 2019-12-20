//
//  Genre.Swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

class Genre: NSObject {
    
    // MARK: - Attributes
    
    let id: Int
    let name: String
    
    // MARK: - Initializers
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    convenience init(genreDTO: GenreDTO) {
        self.init(id: genreDTO.id, name: genreDTO.name)
    }
    
    convenience init(cdGenre: CDGenre) {
        self.init(id: Int(cdGenre.id), name: cdGenre.name!)
    }
}
