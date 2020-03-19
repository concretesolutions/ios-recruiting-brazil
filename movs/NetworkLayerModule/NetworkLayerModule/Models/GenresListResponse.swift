//
//  GenresListResponse.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 19/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

// MARK: - Genres
public struct GenresListResponse: Codable {
    public let genres: [Genre]
    
    // MARK: - Genre
    public struct Genre: Codable {
        
        public let id: Int
        public let name: String
        
        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }
}


