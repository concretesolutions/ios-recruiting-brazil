//
//  ServerURL.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

class ServerURL {
    static let serverSearch = "https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&query=<<query>>&page=<<page>>&include_adult=false"
    static let serverMovies = "https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=<<page>>"
    static let imageW500 = "https://image.tmdb.org/t/p/w500"
    static let imageOriginal = "https://image.tmdb.org/t/p/original"
}
