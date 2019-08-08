//
//  MovieEntityMock.swift
//  MovsTests
//
//  Created by Bruno Chagas on 03/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

@testable import Movs

class MovieEntityMock {
    
    static func createMovieEntityInstance() -> MovieEntity? {
        
        let json =  "{\"vote_count\":1276,\"id\":420818,\"video\":false,\"vote_average\":7.2,\"title\":\"The Lion King\",\"popularity\":373.836,\"poster_path\":\"\\/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg\",\"original_language\":\"en\",\"original_title\":\"The Lion King\",\"genre_ids\":[16],\"backdrop_path\":\"\\/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg\",\"adult\":false,\"overview\":\"Simba idolises his father...\",\"release_date\":\"2019-07-12\"}"
        
        guard let data = json.data(using: .utf8)
        else {
            return nil
        }
        
        guard let movie = try? JSONDecoder().decode(MovieEntity.self, from: data)
        else {
            return nil
        }
        
        return movie
    }
    
}
