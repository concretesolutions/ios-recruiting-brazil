//
//  GenresEntityMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class GenresEntityMock {
    
    static func createGenresEntityInstance() -> GenresEntity? {
        let json =  "{\"genres\":[{\"id\":28,\"name\":\"Action\"},{\"id\":12,\"name\":\"Adventure\"},{\"id\":16,\"name\":\"Animation\"},{\"id\":35,\"name\":\"Comedy\"}]}"
        
        guard let data = json.data(using: .utf8)
            else {
                return nil
        }
        
        guard let genres = try? JSONDecoder().decode(GenresEntity.self, from: data)
        else {
            return nil
        }
        
        return genres
    }
}
