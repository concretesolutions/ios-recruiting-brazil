//
//  Filme.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

//*********************
//MARK: DECODABLE
//*********************

struct InformacoesPesquisa: Decodable {
    
    let total_pages: Int
    let total_results: Int
    let page: Int
    
}

struct Lista: Decodable {
    
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
    
    //SERIE
    let name: String?
    let first_air_date: String?
    let created_by: [created_by]?
    let episode_run_time: [Int]?
    let in_production: Bool?
    let languages: [String]?
    let number_of_episodes: Int?
    let production_companies: [production_companies]?
    
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
//MARK: STRUCTS SERIE DETALHADA
//*********************

struct created_by: Decodable {
    
    let id: Int?
    let credit_id: String?
    let name: String?
    let gender: Int?
    let profile_path: String?
    
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
    
    let filmeDecodable: FilmeDecodable
    
    init(filmeDecodable: FilmeDecodable) {
        self.filmeDecodable = filmeDecodable
    }
    
}
