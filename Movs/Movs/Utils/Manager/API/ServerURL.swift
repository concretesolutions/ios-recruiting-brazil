//
//  ServerURL.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

class ServerURL {
    
    // MARK: - URL Fetch
    static let serverSearch = "https://api.themoviedb.org/3/search/movie?api_key=<<api_key>>&language=en-US&query=<<query>>&page=<<page>>&include_adult=false"
    static let serverMovies = "https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=<<page>>"
    static let serverMovie = "https://api.themoviedb.org/3/movie/<<movie_id>>?api_key=<<api_key>>"
    static let serverGenres = "https://api.themoviedb.org/3/genre/movie/list?api_key=<<api_key>>&language=en-US"
    //static let serverMovieVideo = "https://api.themoviedb.org/3/movie/425505?api_key=d07601d5958c79ba7a3f580704785a43&append_to_response=videos"
    
    // MARK: - URL Images
    static let imageW500 = "https://image.tmdb.org/t/p/w500"
    static let imageOriginal = "https://image.tmdb.org/t/p/original"
    
    // MARK: - Prepare URLs
    
    static func prepareGengesURL() -> String {
        let url = serverGenres.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3)
        return url
    }
    
    static func prepareMoviesURL(page: Int) -> String {
        let url = serverMovies.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3).replacingOccurrences(of: "<<page>>", with: String(page))
        return url
    }
    
    static func prepareMoviesByID(id: Int) -> String {
        let url = serverMovie.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3).replacingOccurrences(of: "<<movie_id>>", with: String(id))
        return url
    }
    
    static func prepareMoviesSearch(page: Int, searchText: String) -> String {
        var url = serverSearch.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3)
        let search = searchText.replacingOccurrences(of: " ", with: "%20")
        url = url.replacingOccurrences(of: "<<query>>", with: search)
        url = url.replacingOccurrences(of: "<<page>>", with: String(page))
        return url
    }
    
}
