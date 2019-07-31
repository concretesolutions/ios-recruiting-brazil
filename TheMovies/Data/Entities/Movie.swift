//
//  Movie.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/26/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import RxSwift


/// Estrutura utilizada para mapear resposta da requisição de filmes
struct MoviesResponse: Codable {
    
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [MovieEntity]
}

struct MovieEntity: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    let overview: String
    let genreIds: [Int]
}


/// Estrutura utilizada no decorrer da aplicação
final class Movie {
    let id: Int
    let title: String
    let image: UIImage
    let releaseDate: String
    let overview: String
    let genres: [Genre]
    private(set) var liked: Bool = false
    
    enum MovieError: Error {
        case genreNotFound
        case imageNotFound
    }
    
    init(id: Int, title: String, image: UIImage, releaseDate: String, overview: String, genres: [Genre], liked: Bool = false) {
        self.id = id
        self.title = title
        self.image = image
        self.releaseDate = releaseDate
        self.overview = overview
        self.genres = genres
        self.liked = liked
    }
    
    func setFavorite(value: Bool) {
        self.liked = value
    }
}

