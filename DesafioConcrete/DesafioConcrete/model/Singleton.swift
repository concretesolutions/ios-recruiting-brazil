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
    
    var populares:Array<Movie> = Array<Movie>()
    var backupPopulares:Array<Movie> = Array<Movie>()
    var genres:Dictionary<Int, Genre> = Dictionary<Int, Genre>()
    var preferidos:Dictionary<Int, Movie> = Dictionary<Int, Movie>()
    var updatePref:Bool = false
    
    private init() {
        if Storage.fileExists("preferidos.json", in: .documents) {
            preferidos = Storage.retrieve("preferidos.json", from: .documents, as: Dictionary<Int, Movie>.self)
        }
    }
    
    func addFavoritos(movie: Movie) {
        preferidos[movie.id] = movie
        updatePref = true
        Storage.store(preferidos, to: .documents, as: "preferidos.json")
    }
    
    func rmvFavoritos(id: Int) {
        preferidos.removeValue(forKey: id)
        updatePref = true
        Storage.store(preferidos, to: .documents, as: "preferidos.json")
    }
    
    func isFavorite(id: Int) -> Bool {
        if let key = preferidos[id] {
            return true
        }
        return false
    }
    
    func findMovie(nome: String) {
        if backupPopulares.isEmpty {
            backupPopulares = populares
        }
        var aux = Array<Movie>()
        for m in backupPopulares {
            if(m.title.contains(nome)) {
                aux.append(m)
            }
        }
        populares = aux
    }
    
    func resetPopulares() {
        populares = backupPopulares
        backupPopulares.removeAll()
    }
    
}
