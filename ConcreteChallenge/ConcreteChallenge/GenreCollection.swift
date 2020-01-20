//
//  GenreCollection.swift
//  ConcreteChallenge
//
//  Created by Kaique Damato on 14/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Foundation

class GenreCollection {
    private var serviceLayer: ServiceLayerProtocol
    private var genres = [Genre]()
    
    init(serviceLayer: ServiceLayerProtocol) {
        self.serviceLayer = serviceLayer
        
        serviceLayer.request(router: .getGenres) { (result: Result<GenreResponse, Error>) in
            switch result {
            case .success(let response):
                self.genres = response.genres
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getId(for genreType: String) -> Int {
        var filteredGenres = [Genre]()
        
        filteredGenres = genres.filter { $0.name == genreType }
        
        return filteredGenres.first?.id ?? 0
    }
    
    func getAllGenresTypes() -> [String] {
        var data = [String]()
        
        data = genres.map { $0.name }
        
        return data
    }
    
    func genres(for ids: [Int]) -> [Genre] {
        var genres = [Genre]()
        
        for genre in self.genres {
            if ids.contains(genre.id) {
                genres.append(genre)
            }
        }
        
        return genres
    }
}
