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
    
    static func prepareMoviesURL(page: Int) -> String {
        let url = serverMovies.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3).replacingOccurrences(of: "<<page>>", with: String(page))
        return url
    }
    
    static func prepareMoviesSearch(page: Int, searchText: String) -> String {
        var url = serverSearch.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3)
        let search = searchText.replacingOccurrences(of: " ", with: "%20")
        url = url.replacingOccurrences(of: "<<query>>", with: search)
        url = url.replacingOccurrences(of: "<<page>>", with: String(page))
        return url
    }
    
//    APIurl.replacingOccurrences(of: "<<api_key>>", with: ServerKeys.serverAPIKeyV3).replacingOccurrences(of: "<<page>>", with: String(page)).replacingOccurrences(of: "<<query>>", with: searchText.replacingOccurrences(of: " ", with: "%20"))
}
