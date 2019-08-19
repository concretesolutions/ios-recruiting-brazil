//
//  Singleton.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
final class Singleton {
    
    static public let shared = Singleton()
    
    var movies:Array<Movie> = Array<Movie>()
    var genres:Dictionary<Int, Genre> = Dictionary<Int, Genre>()
    var preferidos:Dictionary<Int, Movie> = Dictionary<Int, Movie>()
    
    private init() {
        
    }
    
    func addFavoritos(movie: Movie, index: Int) {
        preferidos[movie.id] = movie
        movies[index].isFavorite = true
    }
    
    func rmvFavoritos(id: Int, index: Int) {
        preferidos.removeValue(forKey: id)
        movies[index].isFavorite = false
    }
    
}
