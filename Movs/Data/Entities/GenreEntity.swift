//
//  GenreEntity.swift
//  DesafioConcrete_BrunoChagas
//
//  Created by Bruno Chagas on 23/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation

class GenreEntity: Entity {
    
    //MARK: - Properties
    public var id: Int?
    public var name: String?

    //MARK: - Enumeration
    enum GenreEntityKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    //MARK: - Initialization
    required init(from decoder: Decoder) {
        do {
            let container = try! decoder.container(keyedBy: GenreEntityKeys.self)
            id = try? container.decode(Int.self, forKey: .id)
            name = try? container.decode(String.self, forKey: .name)
        }
    }
    
    //MARK: - Functions
    
    /**
     Creates instances of GenreEntity from genre ids.
     
     - Parameter genresIds: genres ids
     
     - Returns: An array of entity genres generated from genre ids.
     */
    static func gatherMovieGenres(genresIds: [Int]) -> [GenreEntity]{
        var movieGenres: [GenreEntity] = []
        let genres = GenresEntity.getAllGenres()
        
        for genreId in genresIds {
            movieGenres.append((genres?.first(where: {
                (result) -> Bool in
                genreId == result.id
            }))!)

        }
        return movieGenres
    }
    
    /**
     Make a string from genres handed by parameter. Ex: "Action, Animation, Adventure".
     
     - Parameter genres: an array of entity genres
     
     - Returns: A string of genres.
     */
    static func convertMovieGenresToString(genres: [GenreEntity]) -> String{
        var stringGenres: String = ""
        
        for genre in genres {
            if let genreName = genre.name {
                stringGenres += genreName + ", "
            }
        }
                
        stringGenres.removeLast()
        stringGenres.removeLast()
        
        return stringGenres
    }
}

//MARK: -

class GenresEntity: Entity {
    //MARK: - Properties
    public var genres: [GenreEntity] {
        didSet {
            GenresEntity.setAllGenres(genres)
        }
    }
    
    static var allGenres: [GenreEntity]?
    
    //MARK: - Enumeration
    enum GenresEntityKeys: String, CodingKey {
        case genres = "genres"
    }
    
    //MARK: - Initialization
    required init(from decoder: Decoder) {
        let container = try! decoder.container(keyedBy: GenresEntityKeys.self)
        genres = try! container.decode([GenreEntity].self, forKey: .genres)
    }
    
    //MARK: - Functions
    static func setAllGenres(_ genres: [GenreEntity]) {
        GenresEntity.allGenres = genres
    }
    
    static func getAllGenres() -> [GenreEntity]? {
        return GenresEntity.allGenres
    }
    
    
}
