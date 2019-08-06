//
//  GenreEntityMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 03/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class GenreEntityMock {
    
    static func createGenreEntityInstance() -> GenreEntity? {
        
        let json = "{\"id\":16, \"name\":\"Animation\"}"
        
        guard let data = json.data(using: .utf8)
            else {
                return nil
        }
        
        guard let genre = try? JSONDecoder().decode(GenreEntity.self, from: data)
            else {
                return nil
        }
        
        return genre
    }
    
}
