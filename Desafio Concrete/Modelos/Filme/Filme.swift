//
//  Filme.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

//*********************
//MARK: DECODABLE
//*********************

struct Lista: Decodable {
    
    let total_pages: Int
    let total_results: Int
    let page: Int
    let results: [FilmeDecodable]
    
}

struct FilmeDecodable: Decodable {
    
    //FILME
    let title: String?
    let overview: String?
    let release_date: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let backdrop_path: String?
    let adult: Bool?
    let poster_path: String?
    let id: Int?
    let popularity: Float?
    let vote_count: Int?
    let video: Bool?
    let vote_average: Float?
    
    //FILME DETALHADO
    let budget: Float?
    let genres: [genres]?
    let homepage: String?
    let production_countries: [production_countries]?
    let runtime: Int?
    let spoken_languages: [spoken_languages]?
    let imdb_id: String?
    let revenue: Int?
    let status: String?
    let tagline: String?
    let origin_country: [String]?
    let original_name: String?
    let number_of_seasons: Int?
    let last_air_date: String?
    
}

//*********************
//MARK: STRUCTS FILME DETALHADO
//*********************

struct production_companies: Decodable {
    
    let id: Int?
    let logo_path: String?
    let name: String?
    let origin_country: String?
}

struct generosDetalhados: Decodable {
    let genres: [genres]?
}

struct genres: Decodable {
    
    let id: Int?
    let name: String?
}

struct production_countries: Decodable {
    let iso_3166_1: String?
    let name: String?
}

struct spoken_languages: Decodable {
    let iso_639_1: String?
    let name: String?
}

//*********************
//MARK: Filme Objeto
//*********************

class Filme {
        
    var filmeDecodable: FilmeDecodable
    var posterUIImage: UIImage = UIImage()
    var generoFormatado = [String]()
    
    init(filmeDecodable: FilmeDecodable, completion: @escaping (Filme) -> ()) {
        self.filmeDecodable = filmeDecodable
        
        if let generos = filmeDecodable.genres {
            for genero in generos {
                generoFormatado.append(genero.name ?? "")
            }
        }
        
        FuncoesFilme().baixarPosterFilme(filme: filmeDecodable) { (poster) in
            self.posterUIImage = poster
            completion(self)
        }
    }
    
}
