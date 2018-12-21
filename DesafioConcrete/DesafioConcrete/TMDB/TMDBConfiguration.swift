//
//  TMDBConfiguration.swift
//  DesafioConcrete
//
//  Created by Ian Manor on 20/12/18.
//  Copyright © 2018 Ian. All rights reserved.
//

import Foundation

class TMDBConfiguration {
    static let shared = TMDBConfiguration()
    
    var genres: [Int: String]?
    
    private init() {
        self.genres = nil
        loadGenres()
    }
    
    func genre(for id: Int) -> String? {
        return genres?[id]
    }
    
    func loadGenres() {
        let client = TMDBClient()
        client.loadGenres { genres, error in
            guard error == nil else {
                print("Could not load genres list.")
                return
            }
            
            self.genres = genres
        }
    }
}
